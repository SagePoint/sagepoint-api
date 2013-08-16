# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130816222534) do

  create_table "addresses", force: true do |t|
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "post_code"
    t.string  "description"
    t.integer "employer_id"
    t.string  "country"
    t.boolean "enabled",     default: true
  end

  create_table "billings", force: true do |t|
    t.decimal "min_rate",    precision: 10, scale: 0
    t.decimal "max_rate",    precision: 10, scale: 0
    t.integer "duration_id"
    t.integer "currency_id"
  end

  create_table "cert_requirements", force: true do |t|
    t.integer  "task_profile_id", null: false
    t.string   "certification",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certs", force: true do |t|
    t.integer  "user_id",                        null: false
    t.text     "description", limit: 2147483647, null: false
    t.datetime "expires"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clearance_requirements", force: true do |t|
    t.integer  "task_profile_id", null: false
    t.string   "clearance",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clearances", force: true do |t|
    t.integer  "user_id",                        null: false
    t.text     "description", limit: 2147483647, null: false
    t.datetime "expires"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_profiles", force: true do |t|
    t.string  "office_num"
    t.string  "home_num"
    t.string  "cell_num"
    t.string  "pager_num"
    t.integer "business_address_id"
    t.integer "home_address_id"
    t.string  "mailstop"
    t.string  "im_name"
  end

  create_table "devise_users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.integer  "employer_id"
    t.text     "crumb_jar"
    t.datetime "last_report_update"
    t.string   "report_seq"
    t.boolean  "is_enabled",             default: true
    t.boolean  "tos_accepted"
  end

  add_index "devise_users", ["email"], name: "index_devise_users_on_email", unique: true, using: :btree
  add_index "devise_users", ["reset_password_token"], name: "index_devise_users_on_reset_password_token", unique: true, using: :btree

  create_table "divisions", force: true do |t|
    t.string  "name"
    t.integer "employer_id"
    t.boolean "enabled",     default: true
  end

  add_index "divisions", ["name", "employer_id"], name: "index_divisions_on_name_and_employer_id", unique: true, using: :btree

  create_table "drilldowns", force: true do |t|
    t.string   "title"
    t.string   "parameter_list"
    t.integer  "report_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_class"
    t.text     "result_data"
    t.string   "num_results"
    t.string   "threshold"
    t.string   "thres_type"
  end

  create_table "educations", force: true do |t|
    t.integer  "user_id",                        null: false
    t.text     "institution", limit: 2147483647, null: false
    t.text     "degree",      limit: 2147483647, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employers", force: true do |t|
    t.text    "name",                                                    null: false
    t.integer "main_address_id"
    t.boolean "send_email_flag",                         default: false
    t.integer "survey_profile_id"
    t.integer "full_time_utilization",                   default: 40
    t.boolean "suggestion_flag",                         default: false
    t.string  "resource_columns",            limit: 512
    t.boolean "resources_shared",                        default: false
    t.boolean "was_onboarded",                           default: false
    t.boolean "certs_enabled",                           default: true
    t.boolean "pc_enabled",                              default: true
    t.boolean "pc_public",                               default: true
    t.boolean "res_public",                              default: false
    t.string  "sharing_key",                 limit: 6,   default: ""
    t.boolean "allow_unlock",                            default: true
    t.boolean "clearance_enabled",                       default: false
    t.boolean "use_similarity",                          default: true
    t.text    "custom_field_names"
    t.string  "custom_logo"
    t.boolean "allow_resource_task_editing",             default: false
  end

  create_table "employers_roles", id: false, force: true do |t|
    t.integer "employer_id"
    t.integer "role_id"
  end

  create_table "event_types", force: true do |t|
    t.string "name"
    t.string "desc"
  end

  create_table "events", force: true do |t|
    t.string   "description"
    t.string   "status"
    t.integer  "priority"
    t.integer  "event_type_id"
    t.integer  "resource_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codes"
    t.integer  "task_profile_id"
  end

  create_table "expiring_links", force: true do |t|
    t.datetime "expire_time"
    t.string   "destination_url"
    t.string   "uid_code"
    t.string   "optional_pin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "match_logs", force: true do |t|
    t.integer  "employer_id"
    t.integer  "resource_profile_id"
    t.integer  "task_profile_id"
    t.integer  "result_count"
    t.boolean  "has_requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_results", force: true do |t|
    t.integer "resource_profile_id"
    t.integer "task_profile_id",                   null: false
    t.integer "rank",                              null: false
    t.string  "name"
    t.string  "tel"
    t.string  "match_list_string",                 null: false
    t.string  "email"
    t.string  "location"
    t.string  "pay_rate"
    t.integer "active_tasks"
    t.string  "distance"
    t.string  "external_profile_link", limit: 160
  end

  add_index "match_results", ["task_profile_id"], name: "index_match_results_on_task_profile_id", using: :btree

  create_table "metrics", force: true do |t|
    t.string   "query"
    t.string   "description"
    t.datetime "last_run"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_dependencies", force: true do |t|
    t.integer "skill_node_id"
    t.integer "contingency_type"
    t.integer "contingent_node"
  end

  create_table "nodelinks", id: false, force: true do |t|
    t.integer "source_id",      null: false
    t.integer "destination_id", null: false
  end

  create_table "onboard_trackers", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_type_id"
    t.integer  "step_number",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_types", force: true do |t|
    t.string "pay_grade"
    t.string "rate"
  end

  create_table "preferred_skill_groups", force: true do |t|
    t.integer  "employer_id"
    t.integer  "group_name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferred_skills", force: true do |t|
    t.integer  "employer_id"
    t.integer  "skill_group_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "address_id"
    t.text     "description",         limit: 2147483647
    t.text     "project_title"
    t.integer  "resource_profile_id"
    t.integer  "employer_id"
    t.string   "status"
    t.string   "budget"
    t.datetime "start_date"
    t.datetime "est_end_date"
    t.datetime "complete_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_types", force: true do |t|
    t.string   "name"
    t.integer  "version"
    t.text     "description"
    t.datetime "created_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "active_user_code"
    t.integer  "employer_id"
    t.datetime "last_login_time"
    t.datetime "last_report_update"
    t.string   "report_seq"
    t.boolean  "is_enabled",         default: true
    t.boolean  "tos_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
