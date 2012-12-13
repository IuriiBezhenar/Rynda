class AddUserPhonesAndEmails < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string, :limit => Const::INT_SHORT_STRING_LENGTH
    add_column :users, :phone2, :string, :limit => Const::INT_SHORT_STRING_LENGTH
    add_column :users, :email2, :string, :limit => Const::INT_SHORT_STRING_LENGTH
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :phone2
    remove_column :users, :email2
  end
end
