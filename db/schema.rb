# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121212124325) do

  create_table "communities", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.integer  "company_id",               :null => false
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "communities", ["company_id"], :name => "index_communities_on_company_id"

  create_table "contacts", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.integer  "type_id",                   :null => false
    t.integer  "status_id",                 :null => false
    t.integer  "parent_id"
    t.integer  "group_id"
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["group_id"], :name => "index_contacts_on_group_id"
  add_index "contacts", ["parent_id"], :name => "index_contacts_on_parent_id"
  add_index "contacts", ["status_id"], :name => "index_contacts_on_status_id"
  add_index "contacts", ["type_id"], :name => "index_contacts_on_type_id"

  create_table "descriptors", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.integer  "type_id",                   :null => false
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descriptors", ["type_id"], :name => "index_descriptors_on_type_id"

  create_table "privileges", :force => true do |t|
    t.integer  "role_id",                    :null => false
    t.string   "app_name",     :limit => 50, :null => false
    t.string   "class_name",   :limit => 50, :null => false
    t.string   "action_name",  :limit => 50, :null => false
    t.integer  "enabled",                    :null => false
    t.integer  "moderator_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "privileges", ["role_id", "app_name", "class_name", "action_name"], :name => "index_privileges_on_role_appname_class_action"
  add_index "privileges", ["role_id"], :name => "index_privileges_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :limit => 50
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_operations", :force => true do |t|
    t.integer  "type_id",            :null => false
    t.integer  "status_id",          :null => false
    t.datetime "status_date",        :null => false
    t.integer  "company_id",         :null => false
    t.integer  "moderator_id",       :null => false
    t.integer  "prfm_community_id"
    t.integer  "performer_id"
    t.integer  "inspector_id"
    t.integer  "service_request_id"
    t.string   "descr"
    t.string   "report"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_operations", ["company_id"], :name => "index_service_operations_on_company_id"
  add_index "service_operations", ["inspector_id"], :name => "index_service_operations_on_inspector_id"
  add_index "service_operations", ["performer_id"], :name => "index_service_operations_on_performer_id"
  add_index "service_operations", ["service_request_id"], :name => "index_service_operations_on_service_request_id"
  add_index "service_operations", ["status_id"], :name => "index_service_operations_on_status_id"
  add_index "service_operations", ["type_id"], :name => "index_service_operations_on_type_id"

  create_table "service_requests", :force => true do |t|
    t.integer  "type_id",                        :null => false
    t.integer  "status_id",                      :null => false
    t.datetime "status_date",                    :null => false
    t.integer  "company_id",                     :null => false
    t.integer  "requester_id",                   :null => false
    t.integer  "moderator_id",                   :null => false
    t.string   "location_info",    :limit => 25
    t.integer  "hardware_type_id"
    t.string   "hardware_info",    :limit => 25
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_requests", ["company_id"], :name => "index_service_requests_on_company_id"
  add_index "service_requests", ["hardware_type_id"], :name => "index_service_requests_on_hardware_type_id"
  add_index "service_requests", ["moderator_id"], :name => "index_service_requests_on_moderator_id"
  add_index "service_requests", ["requester_id"], :name => "index_service_requests_on_requester_id"
  add_index "service_requests", ["status_id"], :name => "index_service_requests_on_status_id"
  add_index "service_requests", ["type_id"], :name => "index_service_requests_on_type_id"

  create_table "status_tracks", :force => true do |t|
    t.integer  "object_type_id", :null => false
    t.integer  "object_id",      :null => false
    t.integer  "moderator_id",   :null => false
    t.integer  "status_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_tracks", ["moderator_id"], :name => "index_status_tracks_on_moderator_id"
  add_index "status_tracks", ["object_type_id", "object_id", "status_id"], :name => "index_status_tracks_on_objtype_object_status"

  create_table "systypes", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.string   "class_key",  :limit => 25,  :null => false
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_communities", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "community_id", :null => false
    t.integer  "enabled",      :null => false
    t.integer  "moderator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_communities", ["community_id"], :name => "index_user_communities_on_community_id"
  add_index "user_communities", ["user_id", "community_id"], :name => "index_user_communities_on_user_id_and_community_id"
  add_index "user_communities", ["user_id"], :name => "index_user_communities_on_user_id"

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "role_id",      :null => false
    t.integer  "company_id",   :null => false
    t.integer  "enabled",      :null => false
    t.integer  "moderator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["company_id"], :name => "index_user_roles_on_company_id"
  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",              :limit => 25, :null => false
    t.string   "name",               :limit => 50, :null => false
    t.integer  "status_id",                        :null => false
    t.string   "email",                            :null => false
    t.string   "encrypted_password",               :null => false
    t.string   "salt",                             :null => false
    t.integer  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",              :limit => 25
    t.string   "phone2",             :limit => 25
    t.string   "email2",             :limit => 25
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["status_id"], :name => "index_users_on_status_id"

end
