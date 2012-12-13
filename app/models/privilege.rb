class Privilege < ActiveRecord::Base

  #----------------------------------------------
  def self.user_privilege_list(user_id, company_id)
    Privilege.find_by_sql(
      ['select min(privileges.id), privileges.class_name, privileges.action_name ' +
       'from privileges ' +
       'inner join user_roles on ' +
       '           user_roles.user_id = :user_id and ' +
       '           user_roles.role_id = privileges.role_id and ' +
       '           user_roles.enabled = 1 and ' +
       '           user_roles.company_id = :company_id ' +
       'where privileges.app_name = :app_name and ' +
       '      privileges.enabled = 1 ' +
       'group by privileges.class_name, privileges.action_name ' +
       'order by privileges.class_name, privileges.action_name',
       {:user_id    => user_id,
        :app_name   => Const::STR_VALUE_APPLICATION_NAME,
        :company_id => company_id}])
  end

end
