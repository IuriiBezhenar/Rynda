class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :login, :null => false, :limit => Const::INT_SHORT_STRING_LENGTH
      t.string  :name, :null => false, :limit => Const::INT_NAME_SHORT_LENGTH
      t.integer :status_id, :null => false
      t.string  :email, :null => false, :limit => Const::INT_SHORT_STRING_LENGTH
      t.string  :encrypted_password, :null => false
      t.string  :salt, :null => false
      t.integer :admin

      t.timestamps
    end

    add_index :users, :status_id
    add_index :users, :login
  end

  def self.down
    drop_table :users
  end
end
