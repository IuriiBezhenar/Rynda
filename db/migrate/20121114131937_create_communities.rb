class CreateCommunities < ActiveRecord::Migration
  def self.up
    create_table :communities do |t|
      t.string :name, :null => false, :limit => Const::INT_NAME_SHORT_LENGTH
      t.integer :company_id, :null => false
      t.string :descr

      t.timestamps
    end

    add_index :communities, :company_id
  end

  def self.down
    drop_table :communities
  end
end
