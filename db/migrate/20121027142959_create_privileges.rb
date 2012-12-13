class CreatePrivileges < ActiveRecord::Migration
  def self.up
    create_table :privileges do |t|
      t.integer :role_id     , :null => false
      t.string  :app_name    , :null => false, :limit => Const::INT_NAME_SHORT_LENGTH
      t.string  :class_name  , :null => false, :limit => Const::INT_NAME_SHORT_LENGTH
      t.string  :action_name , :null => false, :limit => Const::INT_NAME_SHORT_LENGTH
      t.integer :enabled     , :null => false
      t.integer :moderator_id, :null => false

      t.timestamps
    end
    add_index :privileges, :role_id
    add_index :privileges, [:role_id, :app_name, :class_name, :action_name],
              :name => "index_privileges_on_role_appname_class_action",
              :uniq => true
  end

  def self.down
    drop_table :privileges
  end
end
