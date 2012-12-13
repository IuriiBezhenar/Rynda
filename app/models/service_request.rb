class ServiceRequest < ActiveRecord::Base

  belongs_to :type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :status, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :moderator, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :requester, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :hardware_type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :company

  has_many   :service_operations

  validates :type_id, :presence => true
  validates :status_id, :presence => true
  validates :status_date, :presence => true
  validates :company_id, :presence => true
  validates :moderator_id, :presence => true
  validates :requester_id, :presence => true
  validates :location_info,
            :length => { :maximum => Const::INT_SHORT_STRING_LENGTH }
  validates :hardware_info,
            :length => { :maximum => Const::INT_SHORT_STRING_LENGTH }

  # triggers
  before_validation :assign_defaults
  before_save :before_save_handler
  after_save  :after_save_handler

  #============================================================
  def request_info
    ["##{id}", type.name, requester.name, location_info,
     hardware_type.name, hardware_info].join(' | ')
  end
  #============================================================
  def table_view
    "id: #{id}\n" +
    "company: #{company.name}\n" +
    "type: #{type.name}\n" +
    "status: #{status.name}\n" +
    "created at: #{created_at}\n" +
    (requester ? "requester: #{requester.name}\n" : "") +
    (descr ? "description: #{descr}\n" : "") +
    (location_info ? "location: #{location_info}\n" : "") +
    (hardware_type ? "hardware type: #{hardware_type.name}\n" : "") +
    (hardware_info ? "hardware info: #{hardware_info}" : "")
  end
  #============================================================
  def self.selected_list(user_id, company_id, selector)
    self.internal_selected_list(user_id, company_id, selector)
  end
  #============================================================
  def self.operable_list(company_id)
    ServiceRequest.where(:status_id => [Const::ID_SERVICE_REQ_STATUS_SENT,
                                        Const::ID_SERVICE_REQ_STATUS_RETURNED],
                         :company_id => company_id)
                  .order(:id)
  end
  #============================================================
  def status_track
    StatusTrack.where(:object_type_id => Const::ID_OBJECT_TYPE_SERVICE_REQUEST,
                      :object_id => id).order(Const::STR_FIELD_NAME_CREATED_AT +
                                              Const::STR_VALUE_SQL_DESC)
  end
  #============================================================
  def destroyable?
    status_id == Const::ID_SERVICE_REQ_STATUS_DRAFT
  end
  #============================================================
  def editable?
    status_id == Const::ID_SERVICE_REQ_STATUS_DRAFT
  end
  #============================================================
  def can_be_sent?
    status_id == Const::ID_SERVICE_REQ_STATUS_DRAFT
  end
  #============================================================
  def can_be_assigned?
    status_id == Const::ID_SERVICE_REQ_STATUS_RECEIVED
  end
  #============================================================
  def can_be_received?
    (status_id == Const::ID_SERVICE_REQ_STATUS_SENT) ||
    (status_id == Const::ID_SERVICE_REQ_STATUS_RETURNED)
  end
  #============================================================
  def can_be_activated?
    status_id == Const::ID_SERVICE_REQ_STATUS_ASSIGNED
  end
  #============================================================
  def can_be_processed?
    (status_id == Const::ID_SERVICE_REQ_STATUS_ASSIGNED) ||
    (status_id == Const::ID_SERVICE_REQ_STATUS_ACTIVATED)
  end
  #============================================================
  def can_be_canceled?
    (status_id == Const::ID_SERVICE_REQ_STATUS_SENT     ) ||
    (status_id == Const::ID_SERVICE_REQ_STATUS_RECEIVED ) ||
    (status_id == Const::ID_SERVICE_REQ_STATUS_ACTIVATED)
  end
  #============================================================
  def can_be_approved?
    status_id == Const::ID_SERVICE_REQ_STATUS_PROCESSED
  end
  #============================================================
  def can_be_returned?
    status_id == Const::ID_SERVICE_REQ_STATUS_PROCESSED
  end
  #============================================================
  def get_sent?(user)
    can_be_sent? ? change_status!(user, Const::ID_SERVICE_REQ_STATUS_SENT) : false
  end
  #============================================================
  def get_received?(user, prfm_community_id)
    # test if assigned community comprise at least one performer
    performers = User.available_performers(company_id, prfm_community_id)
    if performers && (performers.count > 0)
      # check existing service operations linked to this request
      service_operations do |so|
        if (so.status_id != Const::ID_SERVICE_OPER_STATUS_DRAFT   ) &&
           (so.status_id != Const::ID_SERVICE_OPER_STATUS_CANCELED)
          return false
        end
      end
      # new service operation will be created here
      internal_get_received?(user, prfm_community_id)
    else
      false
    end
  end
  #============================================================
  def get_received_with_operation?(user, service_operation)
    internal_get_received?(user, nil, service_operation)
  end
  #============================================================
  def get_assigned?(user)
    can_be_assigned? ? change_status!(user, Const::ID_SERVICE_REQ_STATUS_ASSIGNED) : false
  end
  #============================================================
  def get_activated?(user)
    can_be_activated? ? change_status!(user, Const::ID_SERVICE_REQ_STATUS_ACTIVATED) : false
  end
  #============================================================
  def get_processed?(user)
    can_be_processed? ? change_status!(user, Const::ID_SERVICE_REQ_STATUS_PROCESSED) : false
  end
  #============================================================
  def get_canceled?(user)
    can_be_canceled? ? change_status!(user, Const::ID_SERVICE_REQ_STATUS_CANCELED) : false
  end
  #============================================================
  def get_approved?(user, callback_info)
    if can_be_approved?
      service_operations.each do |so|
        so.get_accepted?(user, callback_info)
      end
      change_status!(user, Const::ID_SERVICE_REQ_STATUS_APPROVED)
    else
      false
    end
  end
  #============================================================
  def get_returned?(user, callback_info)
    if can_be_returned?
      service_operations.each do |so|
        so.get_rejected?(user, callback_info)
      end
      change_status!(user, Const::ID_SERVICE_REQ_STATUS_RETURNED)
    else
      false
    end
  end
  #============================================================

  private
  
    #==========================================================
    # substitution with default values
    def assign_defaults
      if new_record?
        self.status_id    = Const::ID_SERVICE_REQ_STATUS_DRAFT unless self.status_id
        self.status_date  = Time.now
        self.moderator_id = requester_id
      end
    end

    #==========================================================
    def before_save_handler
      self.status_date = Time.now if status_id_changed?
    end
    #==========================================================
    def after_save_handler
      if status_id_changed?
        StatusTrack.create_track!(Const::ID_OBJECT_TYPE_SERVICE_REQUEST,
                                  id, moderator_id, status_id)
      end
    end

    #==========================================================
    def internal_get_received?(user, prfm_community_id, service_operation = nil)
      if can_be_received?
        if service_operation.nil?
          ServiceOperation.create_on_request!(self, prfm_community_id)
        end
        change_status!(user, Const::ID_SERVICE_REQ_STATUS_RECEIVED)
      else
        false
      end
    end

    #==========================================================
    def change_status!(user, status_id)
      self.moderator_id = user.id
      self.status_id    = status_id
      self.save!
    end

    #============================================================
    def self.internal_selected_list(user_id, company_id, selector)
      status_list = []
      if (selector.processable == 1) && (selector.archive != 1)
        status_list = [Const::ID_SERVICE_REQ_STATUS_DRAFT,
                       Const::ID_SERVICE_REQ_STATUS_SENT,
                       Const::ID_SERVICE_REQ_STATUS_RECEIVED,
                       Const::ID_SERVICE_REQ_STATUS_ASSIGNED,
                       Const::ID_SERVICE_REQ_STATUS_ACTIVATED,
                       Const::ID_SERVICE_REQ_STATUS_PROCESSED,
                       Const::ID_SERVICE_REQ_STATUS_RETURNED]

      else
        if (selector.processable != 1) && (selector.archive == 1)
          status_list = [Const::ID_SERVICE_REQ_STATUS_APPROVED,
                         Const::ID_SERVICE_REQ_STATUS_CANCELED]
        end
      end

      date1 = selector.date_from
      date2 = date1 ? ((selector.date_to ? selector.date_to : Date.today) + 1) : nil

      condit = "#{Const::STR_FIELD_NAME_COMPANY_ID} = :company_id"
      condit += " and #{Const::STR_FIELD_NAME_STATUS_ID} in (:status_list)"  if (status_list.count > 0)
      condit += " and #{Const::STR_FIELD_NAME_REQUESTER_ID} = :requester_id" if (selector.owned_only == 1)
      condit += " and #{Const::STR_FIELD_NAME_STATUS_DATE} between :date_from and :date_to" if (date1)

      ServiceRequest.where(condit, {:company_id   => company_id,
                                    :status_list  => status_list,
                                    :requester_id => user_id,
                                    :date_from    => date1,
                                    :date_to      => date2}).order(:id)
    end
end
