class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.integer :user_id     , :null => false
      t.integer :role_id     , :null => false
      t.integer :company_id  , :null => false
      t.integer :enabled     , :null => false
      t.integer :moderator_id, :null => false

      t.timestamps
    end
    add_index :user_roles, :user_id
    add_index :user_roles, :role_id
    add_index :user_roles, [:user_id, :role_id], :uniq => true
    add_index :user_roles, :company_id
  end

  def self.down
    drop_table :user_roles
  end
end
