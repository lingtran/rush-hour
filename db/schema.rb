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

ActiveRecord::Schema.define(version: 20160403224853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text     "identifier"
    t.text     "rootUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_names", force: :cascade do |t|
    t.text     "event_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ips", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "ip"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "url_id"
    t.integer  "referred_by_id"
    t.integer  "request_type_id"
    t.integer  "event_name_id"
    t.integer  "user_agent_id"
    t.integer  "ip_id"
    t.integer  "resolution_id"
    t.integer  "client_id"
    t.integer  "responded_in"
    t.text     "digest"
    t.datetime "requested_at"
  end

  create_table "payloads", force: :cascade do |t|
    t.string   "requested_at"
    t.integer  "response_time"
    t.text     "parameters",          default: [],              array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_environment_id"
  end

  add_index "payloads", ["user_environment_id"], name: "index_payloads_on_user_environment_id", using: :btree

  create_table "referred_bies", force: :cascade do |t|
    t.text     "root"
    t.text     "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.text     "verb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.text     "width"
    t.text     "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.text     "root"
    t.text     "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_agents", force: :cascade do |t|
    t.text     "os"
    t.text     "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_environments", force: :cascade do |t|
    t.string   "browser"
    t.string   "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "payloads", "user_environments"
end
