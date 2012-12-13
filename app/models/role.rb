class Role < ActiveRecord::Base

  def dependent_users
    User.find(:all, 
              :joins => 'JOIN user_roles ON user_roles.user_id = users.id and user_roles.enabled = 1').
              uniq
  end
  #----------------------------------------------

  def destroyable?
    dependent_users.count == 0
  end
  #----------------------------------------------
  def granted_privileges
    Privilege.where(:role_id  => id,
                    :app_name => Const::STR_VALUE_APPLICATION_NAME,
                    :enabled  => 1).
              order(:class_name, :action_name)
  end

  #----------------------------------------------
  def grant_privilege!(moderator, class_dot_action)
    p = find_privileges!(class_dot_action)
    if p
      if p.enabled == 0   # privilege has to be enabled
        p.enabled      = 1
        p.moderator_id = moderator.id
        p.save!
      end
    else
      # create new privilege record
      cda = class_dot_action.split(".")
      Privilege.new(:role_id      => id,
                    :app_name     => Const::STR_VALUE_APPLICATION_NAME,
                    :class_name   => cda[0],
                    :action_name  => cda[1],
                    :enabled      => 1,
                    :moderator_id => moderator.id).save!
    end
  end

  #----------------------------------------------
  def revoke_privilege!(moderator, class_dot_action)
    p = find_privileges!(class_dot_action)
    if p
      if p.enabled == 1   # privilege has to be disabled
        p.enabled      = 0
        p.moderator_id = moderator.id
        p.save!
      end
    else
      raise Const::STR_MSG_PRIVILEGE_NOT_FOUND + class_dot_action
    end
  end
  #----------------------------------------------

  private
  
    #----------------------------------------------
    def find_privileges!(class_dot_action)
      cda = class_dot_action.split(".")  # "class_name.action_name"
      if cda.count == 2
        Privilege.find_by_role_id_and_app_name_and_class_name_and_action_name(
          id, Const::STR_VALUE_APPLICATION_NAME, cda[0], cda[1])
      else
        raise Const::STR_MSG_BAD_DATA_FORMAT + class_dot_action.to_s
      end
    end

end
