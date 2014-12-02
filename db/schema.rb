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

ActiveRecord::Schema.define(version: 20141121175922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_plans", force: true do |t|
    t.integer  "claim_issue_id"
    t.string   "action"
    t.string   "author"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_plans", ["claim_issue_id"], name: "index_action_plans_on_claim_issue_id", using: :btree

  create_table "appdefs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "application_title"
    t.text     "application_description"
    t.string   "application_url"
    t.string   "group"
    t.string   "parent_menu_item"
  end

  create_table "claim_issues", force: true do |t|
    t.string   "cr"
    t.string   "item_code"
    t.string   "affected_quantity"
    t.string   "claim_description"
    t.string   "issue_id"
    t.string   "item_description"
    t.string   "line_sequence"
    t.string   "line_text"
    t.string   "quantity"
    t.string   "reason_code"
    t.string   "shipment_number"
    t.string   "status"
    t.string   "tag"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claim_issues", ["claim_id"], name: "index_claim_issues_on_claim_id", using: :btree

  create_table "claims", force: true do |t|
    t.string   "after_hours_contact_name"
    t.string   "after_hours_contact_number"
    t.string   "author"
    t.string   "claim_title"
    t.datetime "creation_date"
    t.string   "dealer_contact_email"
    t.string   "dealer_contact_name"
    t.string   "dealer_contact_number"
    t.string   "dealer_code"
    t.string   "dealer_name"
    t.string   "delivery_claim"
    t.string   "end_customer_name"
    t.string   "installation_company"
    t.string   "installation_in_progress"
    t.string   "installer_email"
    t.string   "installer_name"
    t.string   "installer_number"
    t.datetime "last_modified"
    t.string   "original_po"
    t.string   "original_po_rev"
    t.string   "original_sq"
    t.string   "product_in_storage"
    t.string   "project_name"
    t.string   "replacement_cbd_name"
    t.string   "replacement_cbd_number"
    t.string   "replacement_shipto_address"
    t.string   "replacement_shipto_city"
    t.string   "replacement_shipto_name"
    t.string   "replacement_shipto_state_prov"
    t.string   "replacement_shipto_zip_pc"
    t.string   "scheduled_install_completion"
    t.string   "site_conditions"
    t.string   "site_visit_contact_email"
    t.string   "site_visit_contact_name"
    t.string   "site_visit_contact_number"
    t.datetime "shipment_received_date"
    t.string   "status"
    t.datetime "submission_date"
    t.string   "tekcare_number"
    t.string   "universal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clarifications", force: true do |t|
    t.string   "author"
    t.string   "subject"
    t.string   "question"
    t.string   "answer"
    t.integer  "claim_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clarifications", ["claim_issue_id"], name: "index_clarifications_on_claim_issue_id", using: :btree

  create_table "journal_attachments", force: true do |t|
    t.integer  "journal_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_attachments", ["journal_id"], name: "index_journal_attachments_on_journal_id", using: :btree

  create_table "journals", force: true do |t|
    t.string   "author"
    t.string   "information_type"
    t.string   "title"
    t.text     "information"
    t.integer  "claim_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journals", ["claim_issue_id"], name: "index_journals_on_claim_issue_id", using: :btree

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

  create_table "replacement_orders", force: true do |t|
    t.integer  "action_plan_id"
    t.string   "cr"
    t.string   "list_price"
    t.string   "product_code"
    t.string   "product_desc"
    t.string   "quantity"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replacement_orders", ["action_plan_id"], name: "index_replacement_orders_on_action_plan_id", using: :btree

  create_table "site_visits", force: true do |t|
    t.integer  "claim_issue_id"
    t.datetime "appointment_date"
    t.datetime "appointment_time"
    t.string   "author"
    t.string   "confirmed_by"
    t.string   "site_visit_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_visits", ["claim_issue_id"], name: "index_site_visits_on_claim_issue_id", using: :btree

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
