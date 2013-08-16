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

ActiveRecord::Schema.define(version: 20130816230226) do

  create_table "employers", force: true do |t|
    t.string   "name",                                        null: false
    t.integer  "main_address_id"
    t.boolean  "send_email_flag",             default: false
    t.integer  "survey_profile_id"
    t.integer  "full_time_utilization",       default: 40
    t.boolean  "suggestion_flag",             default: false
    t.string   "resource_columns"
    t.boolean  "resources_shared",            default: false
    t.boolean  "was_onboarded",               default: false
    t.boolean  "certs_enabled",               default: true
    t.boolean  "pc_enabled",                  default: true
    t.boolean  "pc_public",                   default: true
    t.boolean  "res_public",                  default: false
    t.string   "sharing_key"
    t.boolean  "allow_unlock",                default: true
    t.boolean  "clearance_enabled",           default: false
    t.boolean  "use_similarity",              default: true
    t.text     "custom_field_names"
    t.string   "custom_logo"
    t.boolean  "allow_resource_task_editing", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_profiles", force: true do |t|
    t.string   "email"
    t.integer  "employer_id"
    t.integer  "emp_serial_no"
    t.string   "first_name"
    t.string   "surname"
    t.integer  "pay_type_id"
    t.integer  "commited_tasks"
    t.integer  "completed_tasks"
    t.integer  "contact_profile_id"
    t.integer  "user_id"
    t.datetime "hire_date"
    t.text     "about_me"
    t.integer  "commitment",            default: 0
    t.string   "pm_rating"
    t.datetime "contract_end_date"
    t.integer  "manager_id"
    t.integer  "title_id"
    t.integer  "division_id"
    t.boolean  "is_enabled",            default: true
    t.string   "external_profile_link"
    t.text     "custom_field_0"
    t.text     "custom_field_1"
    t.text     "custom_field_2"
    t.boolean  "needs_update",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_aliases", force: true do |t|
    t.integer "user_id",    null: false
    t.text    "alias_hash"
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
