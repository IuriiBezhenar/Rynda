class CreateDescriptors < ActiveRecord::Migration
  def self.up
    create_table :descriptors do |t|
      t.string :name, :null => false, :limit => Const::INT_NAME_STANDARD_LENGTH
      t.integer :type_id, :null => false
      t.string :descr

      t.timestamps
    end

    add_index :descriptors, :type_id
  end

  def self.down
    drop_table :descriptors
  end
end
