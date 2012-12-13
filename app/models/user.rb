require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password

  attr_accessible :type_id, :status_id, :login, :name, :email,
                  :password, :password_confirmation, :company_id

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  belongs_to :type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :status, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  
  has_many :user_roles
  has_many :user_communities
  has_many :communities, :through => :user_communities,
           :conditions => "user_communities.enabled = 1"

  validates :login, :presence   => true,
                    :length     => { :maximum => Const::INT_NAME_SHORT_LENGTH  },
                    :uniqueness => { :case_sensitive => false }

  validates :name,  :presence   => true,
                    :length     => { :maximum => Const::INT_NAME_SHORT_LENGTH  }

  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  # creates the virtual attribute "password_confirmation" automatically
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  validates :status_id, :presence => true

  before_save :encrypt_password

  #----------------------------------------------
  # return true if user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  #----------------------------------------------
  def self.authenticate(login, submitted_password)
    user = User.find_by_login_and_status_id(login, Const::ID_USER_STATUS_ACTIVE)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  #----------------------------------------------
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  #----------------------------------------------
  def privileges_at_company(company_id)
    privs = []
    Privilege.user_privilege_list(id, company_id).each do |p|
      privs << [p.class_name, p.action_name]
    end
    privs
  end

  #----------------------------------------------
  def destroyable?
    !(admin == 1)
  end
  #----------------------------------------------
  def self.active_users
    User.where(:status_id => Const::ID_USER_STATUS_ACTIVE).order(:name, :login)
  end
  #----------------------------------------------
  def granted_roles(company_id)
    result = []
    user_roles.each do |ur|
      result << Role.find_by_id(ur.role_id) if (ur.company_id == company_id && ur.enabled == 1)
    end
    result
  end
  #----------------------------------------------
  def available_roles(company_id)
    role_ids = []
    user_roles.each do |ur|
      role_ids << ur.role_id if (ur.company_id == company_id && ur.enabled == 1)
    end
    if role_ids.count > 0
      Role.where('id NOT IN (?)', role_ids)
    else
      Role.all
    end
  end
  #----------------------------------------------
  def grant_role!(moderator, role_id, company_id)
    ur = UserRole.find_by_user_id_and_role_id_and_company_id(id, role_id, company_id)
    if ur.nil? || (ur.enabled == 0)
        # create new record with enabled = 1
        UserRole.new(:user_id      => id,
                     :role_id      => role_id,
                     :company_id   => company_id,
                     :enabled      => 1,
                     :moderator_id => moderator.id).save!
    else
      # enable disabled record overwriting moderator
      ur.update_attributes!(:enabled => 1, :moderator_id => moderator.id)
    end
  end
  #----------------------------------------------
  def revoke_role!(moderator, role_id, company_id)
    ur = UserRole.find_by_user_id_and_role_id_and_company_id(id, role_id, company_id)
    if ur && (ur.enabled == 1)
      # disable enabled record overwriting moderator
      ur.update_attributes!(:enabled => 0, :moderator_id => moderator.id)
    else
      raise Const::STR_MSG_ROLE_NOT_FOUND + role_id.to_s
    end
  end

  #----------------------------------------------
  def self.available_performers(company_id, community_id)
    self.privileged_user_list(Const::STR_CLASS_SERVICE_OPERATIONS_CONTR,
                              Const::STR_PA_GET_TO_PERFORM, company_id, community_id)
  end

  #----------------------------------------------
  # user must have at least one available community linked to company
  def available_companies(except_company = nil)
    if admin == 1
      result = Company.all_active.to_a   # without to_a "no marshal_dump is defined for class Mutex" raises
    else
      result = []
      communities.each do |ac|
        # check this company in result array
        company = ac.company
        found = false
        result.each do |cmp|
          found = true if cmp.id == company.id
        end
        result << ac.company unless found
      end
      result
    end
    result.reject { |e| e == except_company }
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    #----------------------------------------------
    # e.g. collect the list of users that can be assigned as performer
    def self.privileged_user_list(class_name, action_name,
                                  company_id, community_id = nil)
      sql =
        'select distinct users.* ' +
        'from users ' +
        'inner join user_roles on ' +
        '           user_roles.user_id = users.id and user_roles.enabled = 1 and ' +
        '           user_roles.company_id = :company_id ' +
        'inner join privileges on ' +
        '           privileges.role_id = user_roles.role_id and ' +
        '           privileges.enabled = 1 and ' +
        '           privileges.app_name = :app_name and ' +
        '           privileges.class_name = :class_name and ' +
        '           privileges.action_name = :action_name '

      if community_id
        sql +=
        'inner join user_communities on ' +
        '           user_communities.user_id = users.id and ' +
        '           user_communities.community_id = :community_id and ' +
        '           user_communities.enabled = 1 '
      end

      User.find_by_sql([sql,
         {:app_name => Const::STR_VALUE_APPLICATION_NAME,
          :class_name   => class_name,
          :action_name  => action_name,
          :company_id   => company_id,
          :community_id => community_id}])
    end

end
