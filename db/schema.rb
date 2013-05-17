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

ActiveRecord::Schema.define(version: 20130517173551) do

  create_table "channels", force: true do |t|
    t.string   "id_string"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.integer  "channel_id"
    t.integer  "movie_path"
    t.integer  "event_id"
    t.boolean  "freeCA"
    t.string   "audio"
    t.string   "video"
    t.string   "attachinfo"
    t.string   "title"
    t.string   "detail"
    t.text     "extdetail"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "duration"
    t.text     "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
