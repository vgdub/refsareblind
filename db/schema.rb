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

ActiveRecord::Schema.define(version: 20130602050234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nfl_matchups", force: true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "week"
    t.decimal  "point_spread",    precision: 3, scale: 1
    t.integer  "home_team_score"
    t.integer  "away_team_score"
    t.boolean  "final",                                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfl_picks", force: true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "nfl_team_id"
    t.integer  "week"
    t.boolean  "locked",      default: false
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfl_teams", force: true do |t|
    t.string   "city"
    t.string   "conference", limit: 3
    t.string   "division",   limit: 5
    t.string   "name"
    t.string   "abbr",       limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_types", force: true do |t|
    t.string   "sport"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.string   "role",       default: "member"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",   default: false
    t.string   "name"
  end

  create_table "pools", force: true do |t|
    t.integer  "pool_type_id"
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",          default: false
    t.string   "name"
    t.string   "slug"
    t.boolean  "active",          default: true
    t.boolean  "payment_settled"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             default: true
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
