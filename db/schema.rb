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

ActiveRecord::Schema.define(version: 20150613080050) do

  create_table "concepts", force: :cascade do |t|
    t.integer  "entry_id"
    t.string   "text"
    t.decimal  "relevance",  precision: 6, scale: 5
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "entries", force: :cascade do |t|
    t.integer  "feed_id"
    t.string   "atom_id"
    t.string   "title"
    t.string   "url"
    t.text     "content",         limit: 65536
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "sentiment"
    t.decimal  "sentiment_score",                  precision: 6, scale: 5
    t.string   "image"
    t.text     "extracted_text",  limit: 16777215
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.integer  "entry_id"
    t.string   "text"
    t.decimal  "relevance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "email"
    t.integer  "frequency"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "last_entry_id"
  end

end
