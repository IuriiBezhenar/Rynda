class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.integer :company_id
      t.integer :parent_id
      t.integer :type_id
      t.string :descr
      t.integer :disabled

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
