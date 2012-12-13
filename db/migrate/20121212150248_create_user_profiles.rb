class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :position_id
      t.integer :location_id
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
