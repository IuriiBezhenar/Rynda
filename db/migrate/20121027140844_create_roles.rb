class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :limit => Const::INT_NAME_SHORT_LENGTH
      t.string :descr

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
