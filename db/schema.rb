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

ActiveRecord::Schema.define(version: 20141018185259) do

  create_table "key_columns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.integer  "key_row_id"
    t.integer  "originalorder"
  end

  create_table "key_rows", force: true do |t|
    t.string   "name"
    t.integer  "spreadsheetdoc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "key_rows", ["spreadsheetdoc_id"], name: "index_key_rows_on_spreadsheetdoc_id"

  create_table "plans", force: true do |t|
    t.integer  "price"
    t.string   "name"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "combinedfile"
    t.boolean  "skip_multiple"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "projects_spreadsheetdocs", id: false, force: true do |t|
    t.integer "spreadsheetdoc_id", null: false
    t.integer "project_id",        null: false
  end

  add_index "projects_spreadsheetdocs", ["project_id"], name: "index_projects_spreadsheetdocs_on_project_id"
  add_index "projects_spreadsheetdocs", ["spreadsheetdoc_id"], name: "index_projects_spreadsheetdocs_on_spreadsheetdoc_id"

  create_table "spreadsheetdocs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spreadsheetfile"
    t.integer  "user_id"
  end

  add_index "spreadsheetdocs", ["user_id"], name: "user_id_ix"

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.date     "active_until"
    t.boolean  "active"
    t.boolean  "recurring"
    t.string   "product_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
