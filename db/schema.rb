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

ActiveRecord::Schema.define(version: 20150703231116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendences", force: true do |t|
    t.integer  "meeting_id"
    t.integer  "brother_id"
    t.integer  "creator_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendences", ["brother_id"], name: "index_attendences_on_brother_id", using: :btree
  add_index "attendences", ["creator_id"], name: "index_attendences_on_creator_id", using: :btree
  add_index "attendences", ["meeting_id"], name: "index_attendences_on_meeting_id", using: :btree

  create_table "balances", force: true do |t|
    t.integer  "kind"
    t.integer  "value"
    t.integer  "brother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "balances", ["brother_id"], name: "index_balances_on_brother_id", using: :btree

  create_table "brothers", force: true do |t|
    t.string   "name"
    t.integer  "year"
    t.integer  "pledge_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current"
    t.string   "kerberos"
    t.integer  "position"
  end

  add_index "brothers", ["pledge_class_id"], name: "index_brothers_on_pledge_class_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetings", ["creator_id"], name: "index_meetings_on_creator_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "brother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["brother_id"], name: "index_memberships_on_brother_id", using: :btree
  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree

  create_table "pledge_classes", force: true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shortlogs", force: true do |t|
    t.integer  "log_type"
    t.text     "content"
    t.integer  "brother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortlogs", ["brother_id"], name: "index_shortlogs_on_brother_id", using: :btree

end
