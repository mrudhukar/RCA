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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120927112944) do

  create_table "bugs", :force => true do |t|
    t.integer  "team_id"
    t.string   "title"
    t.text     "description"
    t.integer  "pt_id"
    t.integer  "root_cause_bugs_count"
    t.boolean  "ignored",               :default => false
    t.text     "labels"
    t.date     "conducted_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "followups", :force => true do |t|
    t.integer  "root_cause_id"
    t.string   "title"
    t.text     "description"
    t.integer  "pt_id"
    t.integer  "user_id"
    t.date     "expected_date"
    t.integer  "status",        :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "root_cause_bugs", :force => true do |t|
    t.integer  "root_cause_id"
    t.integer  "bug_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "root_cause_bugs", ["root_cause_id", "bug_id"], :name => "index_root_cause_bugs_on_root_cause_id_and_bug_id"

  create_table "root_causes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "root_cause_bugs_count"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "team_id"
  end

  create_table "team_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "admin",      :default => false
  end

  create_table "teams", :force => true do |t|
    t.string   "title"
    t.integer  "project_id"
    t.string   "token"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "label",      :default => "rca"
    t.string   "story_type", :default => "bug, chore, feature"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                  :null => false
    t.string   "email",                                 :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                     :null => false
    t.string   "perishable_token",   :default => "",    :null => false
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "admin",              :default => false
    t.text     "token"
  end

end
