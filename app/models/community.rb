class Community < ActiveRecord::Base

  belongs_to :company
  has_many :user_communities
  has_many :users, :through => :user_communities,
           :conditions => "user_communities.enabled = 1"

  #----------------------------------------------
  def destroyable?
    users.count == 0
  end

  #----------------------------------------------
  def include_member!(moderator, user_id)
    uc = UserCommunity.find_by_user_id_and_community_id(user_id, id)
    if uc
      if uc.enabled == 0   # has to be enabled
        uc.enabled      = 1
        uc.moderator_id = moderator.id
        uc.save!
      end
    else
      # create new user-community association
      UserCommunity.new(:user_id      => user_id,
                        :community_id => id,
                        :enabled      => 1,
                        :moderator_id => moderator.id).save!
    end
  end

  #----------------------------------------------
  def exclude_member!(moderator, user_id)
    uc = UserCommunity.find_by_user_id_and_community_id(user_id, id)
    if uc
      if uc.enabled == 1   # has to be disabled
        uc.enabled      = 0
        uc.moderator_id = moderator.id
        uc.save!
      end
    else
      raise Const::STR_MSG_USER_COMMUNITY_NOT_FOUND +
            "user.id=" + user_id.to_s + "; community.id=" + id.to_s
    end
  end

end
