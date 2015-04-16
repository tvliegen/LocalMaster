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

ActiveRecord::Schema.define(version: 20150415194950) do

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

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_installer_certfication_certs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_installer_certifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companyid"
    t.string   "companyname"
    t.string   "companyaddress"
    t.string   "companycity"
    t.string   "companyprovstate"
    t.string   "companycountry"
    t.string   "companypostalzip"
    t.string   "companycontactname"
    t.string   "companycontactnumber"
    t.string   "companycontactemail"
    t.string   "companydealers"
    t.string   "companyprojects"
    t.string   "companycomments"
  end

  create_table "internal_installer_certifications_installers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companyid"
    t.integer  "installerid"
    t.string   "installername"
    t.string   "installercontactnumber"
    t.string   "installercontactemail"
  end

  create_table "internal_installers_certifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companyid"
    t.string   "companyname"
    t.string   "companyaddress"
    t.string   "companycity"
    t.string   "companyprovstate"
    t.string   "companycountry"
    t.string   "companypostalzip"
    t.string   "companycontactname"
    t.string   "companycontactnumber"
    t.string   "companycontactemail"
    t.string   "companydealers"
    t.string   "companyprojects"
    t.string   "companycomments"
  end

  create_table "internal_installers_certifications_installers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companyid"
    t.integer  "installerid"
    t.string   "installername"
    t.string   "installercontactnumber"
    t.string   "installercontactemail"
  end

  create_table "internal_installers_certifications_installers_certs", force: true do |t|
    t.integer "companyid"
    t.integer "installerid"
    t.integer "certid"
    t.string  "certname"
    t.date    "certtrainingdate"
    t.date    "certexpirydate"
    t.boolean "certauditcomplete"
    t.string  "certnumber"
  end

  create_table "internal_massmails", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "description"
    t.string   "author"
    t.string   "subject"
    t.string   "content"
    t.string   "distributionid"
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

  create_table "teknion_rga_details", force: true do |t|
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

  create_table "utilities_boxtokens", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "AccessToken"
    t.date     "CreateToken"
    t.string   "RefreshToken"
  end

end
