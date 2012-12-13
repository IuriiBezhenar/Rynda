class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string  :name, :null => false, :limit => Const::INT_NAME_STANDARD_LENGTH
      t.integer :type_id, :null => false
      t.integer :status_id, :null => false
      t.integer :parent_id
      t.integer :group_id
      t.string  :descr

      t.timestamps
    end

    add_index :contacts, :type_id
    add_index :contacts, :status_id
    add_index :contacts, :parent_id
    add_index :contacts, :group_id
  end

  def self.down
    drop_table :contacts
  end
end
