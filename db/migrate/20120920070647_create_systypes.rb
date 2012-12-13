class CreateSystypes < ActiveRecord::Migration
  def self.up
    create_table :systypes do |t|
      t.string :name, :null => false, :limit => Const::INT_NAME_STANDARD_LENGTH
      t.string :class_key, :null => false, :limit => 25
      t.string :descr

      t.timestamps
    end
  end

  def self.down
    drop_table :systypes
  end
end
