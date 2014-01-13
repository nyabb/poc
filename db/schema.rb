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

ActiveRecord::Schema.define(version: 20140109105820) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "from_user"
    t.integer  "to_user"
    t.string   "body"
    t.string   "message_type"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reactions_to"
  end

  create_table "offers", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "message"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "fulfilled"
    t.string   "offer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reactions", force: true do |t|
    t.string   "react_type"
    t.integer  "react_to"
    t.string   "message"
    t.integer  "userId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "date_of_birth"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "mobile_phone"
    t.string   "adres"
    t.string   "zipcode"
    t.string   "place"
    t.datetime "last_online"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "remember_token"
    t.string   "facebook_uid"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "radius"
    t.integer  "country_id"
  end

  add_index "users", ["facebook_uid"], name: "index_users_on_facebook_uid"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
