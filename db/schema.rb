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

ActiveRecord::Schema.define(version: 20141217160732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appdefs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "application_title"
    t.text     "application_description"
    t.string   "application_url"
    t.string   "group"
    t.string   "parent_menu_item"
  end

  create_table "login_authenticates", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password"
    t.string   "language"
  end

  create_table "portalmanager_appdefs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "application_title"
    t.string   "application_url"
    t.string   "application_groups"
    t.string   "application_parent_menu"
    t.string   "externauthurl"
  end

  create_table "teknion_backcharges", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teknionline_profiles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "userid"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "login"
    t.string   "language"
  end

  create_table "usermanagement_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "mobile"
    t.string   "language"
    t.string   "groups"
    t.string   "password"
    t.string   "password_confirm"
  end

end
