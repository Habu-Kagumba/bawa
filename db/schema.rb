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

ActiveRecord::Schema.define(version: 20160429084845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "booking_id"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "flight_id"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "bookings", ["flight_id"], name: "index_bookings_on_flight_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "flights", force: :cascade do |t|
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.integer  "departure_location_id"
    t.integer  "arrival_location_id"
    t.string   "flight_number"
    t.string   "airline"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "flights", ["arrival_location_id"], name: "index_flights_on_arrival_location_id", using: :btree
  add_index "flights", ["departure_location_id"], name: "index_flights_on_departure_location_id", using: :btree

  create_table "passengers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "booking_id"
    t.integer  "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "passengers", ["booking_id"], name: "index_passengers_on_booking_id", using: :btree
  add_index "passengers", ["flight_id"], name: "index_passengers_on_flight_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "username"
    t.string   "slug"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
