class CreateServiceOperations < ActiveRecord::Migration
  def self.up
    create_table :service_operations do |t|
      t.integer  :type_id,      :null => false
      t.integer  :status_id,    :null => false
      t.datetime :status_date,  :null => false
      t.integer  :company_id,   :null => false
      t.integer  :moderator_id, :null => false
      t.integer  :prfm_community_id
      t.integer  :performer_id
      t.integer  :inspector_id
      t.integer  :service_request_id
      t.string   :descr
      t.string   :report
      t.string   :remark

      t.timestamps
    end

    add_index :service_operations, :type_id
    add_index :service_operations, :status_id
    add_index :service_operations, :company_id
    add_index :service_operations, :performer_id
    add_index :service_operations, :inspector_id
    add_index :service_operations, :service_request_id
  end

  def self.down
    drop_table :service_operations
  end
end
