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
    t.integer  "entry_id",   limit: 4
    t.string   "text",       limit: 255
    t.decimal  "relevance",              precision: 6, scale: 5
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "feed_id",         limit: 4
    t.string   "atom_id",         limit: 255
    t.string   "title",           limit: 255
    t.string   "url",             limit: 255
    t.text     "content",         limit: 16777215
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "sentiment",       limit: 255
    t.decimal  "sentiment_score",                  precision: 6, scale: 5
    t.string   "image",           limit: 255
    t.text     "extracted_text",  limit: 16777215
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.integer  "entry_id",   limit: 4
    t.string   "text",       limit: 255
    t.decimal  "relevance",              precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.integer  "frequency",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "last_entry_id", limit: 4
  end

end
