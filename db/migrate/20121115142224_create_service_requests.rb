class CreateServiceRequests < ActiveRecord::Migration
  def self.up
    create_table :service_requests do |t|
      t.integer  :type_id, :null => false
      t.integer  :status_id, :null => false
      t.datetime :status_date, :null => false
      t.integer  :company_id, :null => false
      t.integer  :requester_id, :null => false
      t.integer  :moderator_id, :null => false
      t.string   :location_info, :limit => Const::INT_SHORT_STRING_LENGTH
      t.integer  :hardware_type_id
      t.string   :hardware_info, :limit => Const::INT_SHORT_STRING_LENGTH
      t.string   :descr

      t.timestamps
    end

    add_index :service_requests, :type_id
    add_index :service_requests, :status_id
    add_index :service_requests, :company_id
    add_index :service_requests, :requester_id
    add_index :service_requests, :moderator_id
    add_index :service_requests, :hardware_type_id
  end

  def self.down
    drop_table :service_requests
  end
end
