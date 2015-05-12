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

ActiveRecord::Schema.define(version: 20150509021033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "dogs", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.string   "breed"
    t.datetime "birthday"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "marks", force: :cascade do |t|
    t.integer  "walk_id"
    t.geometry "coords",     limit: {:srid=>0, :type=>"point"}
    t.integer  "accuracy"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "walked_dogs", force: :cascade do |t|
    t.integer "walk_id"
    t.integer "dog_id"
  end

  create_table "walks", force: :cascade do |t|
    t.integer  "user_id"
    t.geometry "walk_territory", limit: {:srid=>0, :type=>"polygon"}
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

end
