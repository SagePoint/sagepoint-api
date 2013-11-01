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

ActiveRecord::Schema.define(version: 20131016230000) do

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

  create_table "reports", force: true do |t|
    t.string   "title"
    t.string   "parameter_list"
    t.integer  "report_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "employer_id"
  end

  create_table "resource_profiles", force: true do |t|
    t.string   "email"
    t.integer  "employer_id"
    t.string   "emp_serial_no"
    t.string   "first_name"
    t.string   "surname"
    t.integer  "pay_type_id"
    t.integer  "committed_tasks"
    t.integer  "completed_tasks"
    t.integer  "contact_profile_id"
    t.integer  "user_id"
    t.datetime "hire_date"
    t.datetime "created_at"
    t.text     "about_me"
    t.integer  "commitment",                        default: 0
    t.string   "pm_rating"
    t.datetime "contract_end_date"
    t.integer  "manager_id"
    t.integer  "title_id"
    t.integer  "division_id"
    t.boolean  "is_enabled",                        default: true
    t.string   "external_profile_link", limit: 160
    t.text     "custom_field_0"
    t.text     "custom_field_1"
    t.text     "custom_field_2"
    t.boolean  "needs_update",                      default: false
  end

  create_table "resource_requests", force: true do |t|
    t.integer  "resource_profile_id",    null: false
    t.integer  "requesting_employer_id", null: false
    t.integer  "requesting_manager_id",  null: false
    t.integer  "task_profile_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "approved_date"
    t.string   "status"
  end

  create_table "roles", force: true do |t|
    t.string "role_desc"
  end

  add_index "roles", ["role_desc"], name: "index_roles_on_role_desc", unique: true, using: :btree

  create_table "roles_skill_trees", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "skill_tree_id"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "schedules", force: true do |t|
  end

  create_table "schema_info", id: false, force: true do |t|
    t.integer "version"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id",                  null: false
    t.text     "data",       limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sharing_profiles", force: true do |t|
    t.integer  "employer_id"
    t.integer  "partner_id"
    t.integer  "profile_type",               default: 1
    t.string   "status"
    t.string   "description"
    t.string   "hidden_fields", limit: 512
    t.string   "filters",       limit: 2048
    t.datetime "request_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shared_tasks",               default: 0
  end

  create_table "skill_aliases", force: true do |t|
    t.string  "name"
    t.integer "skill_id",    null: false
    t.integer "employer_id"
  end

  create_table "skill_keys", force: true do |t|
    t.integer "skill_id",   null: false
    t.string  "ids_string", null: false
  end

  create_table "skill_node_aliases", force: true do |t|
    t.integer "skill_node_id", null: false
    t.integer "employer_id"
    t.string  "name"
  end

  create_table "skill_nodes", force: true do |t|
    t.string  "name"
    t.integer "node_type", null: false
  end

  create_table "skill_paths", force: true do |t|
    t.integer "skill_key_id"
    t.string  "skill_tree_node_list"
  end

  create_table "skill_paths_skill_tree_nodes", id: false, force: true do |t|
    t.integer "skill_path_id"
    t.integer "skill_tree_node_id"
  end

  create_table "skill_ratings", force: true do |t|
    t.integer  "val",                 null: false
    t.integer  "skill_id",            null: false
    t.integer  "resource_profile_id"
    t.integer  "certification_level", null: false
    t.integer  "skill_level",         null: false
    t.text     "answer_list_c",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_used_time"
  end

  add_index "skill_ratings", ["skill_id", "val"], name: "skill_rating_and_skill_id", using: :btree
  add_index "skill_ratings", ["skill_id"], name: "index_skill_ratings_on_skill_id", using: :btree

  create_table "skill_requirements", force: true do |t|
    t.integer "skill_id",                         null: false
    t.integer "task_profile_id",                  null: false
    t.integer "skill_req_weight",                 null: false
    t.string  "requirement_type"
    t.float   "threshold",        default: 100.0
  end

  add_index "skill_requirements", ["task_profile_id"], name: "index_skill_requirements_on_task_profile_id", using: :btree

  create_table "skill_similars", force: true do |t|
    t.integer  "skill_id"
    t.integer  "similar_skill_id",               null: false
    t.float    "similarity",       default: 0.0, null: false
    t.integer  "adjustment",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_similars", ["skill_id", "similarity"], name: "skill_similarity_and_skill_id", using: :btree

  create_table "skill_suggestions", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "employer_id", null: false
    t.string   "skill_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_tree_nodes", force: true do |t|
    t.integer "skill_tree_id"
    t.integer "skill_node_id",                null: false
    t.integer "parent_id"
    t.string  "name"
    t.boolean "is_leaf_node",  default: true
  end

  create_table "skill_trees", force: true do |t|
    t.string  "desc"
    t.integer "tree_root_node_id"
  end

  create_table "skill_webs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string "skill_desc"
  end

  add_index "skills", ["skill_desc"], name: "skill_desc"

  create_table "survey_profiles", force: true do |t|
    t.string  "survey_version"
    t.integer "skill_level_min",                         null: false
    t.integer "num_answers",                             null: false
    t.integer "curve_type",                              null: false
    t.integer "skill_level_max",                         null: false
    t.integer "time_slices",                             null: false
    t.float   "retention_rate",                          null: false
    t.integer "cert",                                    null: false
    t.integer "corner_value_max",                        null: false
    t.float   "lfm_ts_recent",                           null: false
    t.integer "bands",                                   null: false
    t.integer "corner_value_mid_1",                      null: false
    t.float   "lfm_ts_distant",                          null: false
    t.integer "confidence_bands",                        null: false
    t.integer "corner_value_mid_2",                      null: false
    t.integer "num_skill_levels",                        null: false
    t.integer "corner_value_min",                        null: false
    t.integer "max_rating_value",                        null: false
    t.integer "min_rating_value",                        null: false
    t.float   "skill_survey_score",     default: 1.0
    t.float   "resume_task_multiplier", default: 0.0899
    t.integer "history_duration_days",  default: 60
    t.string  "uvalues"
    t.string  "pvalues"
    t.float   "sum_coefficient",        default: 1.0
  end

  create_table "task_assignments", force: true do |t|
    t.integer  "resource_profile_id"
    t.integer  "task_profile_id"
    t.string   "status"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hours_worked"
    t.integer  "project_manager_id"
    t.integer  "pm_rating"
    t.integer  "credit"
    t.string   "pm_feedback"
    t.datetime "closed_at"
  end

  add_index "task_assignments", ["resource_profile_id"], name: "index_task_assignments_on_resource_profile_id", using: :btree

  create_table "task_profiles", force: true do |t|
    t.string   "task_desc"
    t.integer  "location_id"
    t.integer  "project_id"
    t.integer  "billing_id"
    t.datetime "last_match_time"
    t.string   "task_status",                             null: false
    t.boolean  "geo_required"
    t.boolean  "init_required"
    t.integer  "geo_weight"
    t.integer  "init_weight"
    t.datetime "start_time"
    t.datetime "complete_time"
    t.datetime "est_complete_time"
    t.boolean  "exclusive",               default: false
    t.text     "comments"
    t.integer  "task_type_id"
    t.integer  "effort_hours"
    t.integer  "resource_profile_id"
    t.integer  "employer_id"
    t.string   "scope_modifier"
    t.boolean  "work_in_progress"
    t.boolean  "enabled",                 default: true
    t.string   "title",                   default: ""
    t.boolean  "is_shared",               default: false
    t.boolean  "is_locked",               default: false
    t.boolean  "is_editable_by_resource", default: false
  end

  create_table "task_types", force: true do |t|
    t.string  "name"
    t.integer "task_type_weight"
  end

  create_table "titles", force: true do |t|
    t.string  "name"
    t.integer "employer_id"
    t.boolean "enabled",     default: true
  end

  add_index "titles", ["name", "employer_id"], name: "index_titles_on_name_and_employer_id", unique: true, using: :btree

  create_table "user_aliases", force: true do |t|
    t.integer "user_id",    null: false
    t.text    "alias_hash"
  end

  create_table "user_types", force: true do |t|
    t.string "desc"
    t.string "code"
    t.string "homepage"
  end

  create_table "user_types_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "user_type_id"
  end

  add_index "user_types_users", ["user_id", "user_type_id"], name: "user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "active_user_code"
    t.integer  "employer_id"
    t.text     "crumb_jar"
    t.datetime "last_login_time"
    t.datetime "last_report_update"
    t.string   "report_seq"
    t.boolean  "is_enabled",             default: true
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email", "employer_id"], name: "index_users_on_email_and_employer_id", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
