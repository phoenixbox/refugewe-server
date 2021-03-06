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

ActiveRecord::Schema.define(version: 20151016040856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "addresses", force: :cascade do |t|
    t.string   "line_1",              null: false
    t.string   "line_2"
    t.string   "line_3"
    t.string   "city"
    t.string   "province"
    t.string   "zipcode"
    t.integer  "iso_country_code_cd", null: false
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "type_cd",             null: false
    t.integer  "addressable_id"
    t.string   "addressable_type"
  end

  add_index "addresses", ["iso_country_code_cd"], name: "index_addresses_on_iso_country_code_cd", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.string   "token",      null: false
    t.integer  "user_id",    null: false
    t.integer  "expiration"
    t.string   "token_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.integer  "medical_record_id"
    t.integer  "type_cd"
    t.integer  "stage_cd"
    t.integer  "mdc_cd"
    t.integer  "mdc_description_cd"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "conditions", ["mdc_cd"], name: "index_conditions_on_mdc_cd", using: :btree
  add_index "conditions", ["mdc_description_cd"], name: "index_conditions_on_mdc_description_cd", using: :btree
  add_index "conditions", ["stage_cd"], name: "index_conditions_on_stage_cd", using: :btree
  add_index "conditions", ["type_cd"], name: "index_conditions_on_type_cd", using: :btree

  create_table "consultations", force: :cascade do |t|
    t.text     "description"
    t.integer  "medical_record_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "consultations", ["medical_record_id"], name: "index_consultations_on_medical_record_id", using: :btree
  add_index "consultations", ["user_id"], name: "index_consultations_on_user_id", using: :btree

  create_table "dependents", force: :cascade do |t|
    t.integer  "relationship_cd", null: false
    t.integer  "source_user_id",  null: false
    t.integer  "target_user_id",  null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "format_cd",         null: false
    t.integer  "category_cd",       null: false
    t.string   "title"
    t.text     "description"
    t.text     "url",               null: false
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "dosages", force: :cascade do |t|
    t.integer  "value"
    t.integer  "unit_cd"
    t.integer  "drug_id"
    t.integer  "prescription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dosages", ["drug_id"], name: "index_dosages_on_drug_id", using: :btree
  add_index "dosages", ["prescription_id"], name: "index_dosages_on_prescription_id", using: :btree
  add_index "dosages", ["unit_cd"], name: "index_dosages_on_unit_cd", using: :btree

  create_table "drugs", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "type_cd"
    t.integer  "prescription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drugs", ["prescription_id"], name: "index_drugs_on_prescription_id", using: :btree

  create_table "facebook_profiles", force: :cascade do |t|
    t.string   "uid",               null: false
    t.string   "username"
    t.string   "display_name",      null: false
    t.string   "email",             null: false
    t.integer  "authentication_id", null: false
    t.string   "token",             null: false
    t.hstore   "raw"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "photo_url"
  end

  add_index "facebook_profiles", ["raw"], name: "index_facebook_profiles_on_raw", using: :gin

  create_table "families", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_users", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "family_users", ["family_id"], name: "index_family_users_on_family_id", using: :btree
  add_index "family_users", ["user_id"], name: "index_family_users_on_user_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.integer  "interval_value"
    t.integer  "interval_unit_cd"
    t.text     "notes"
    t.integer  "dosage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructions", ["dosage_id"], name: "index_instructions_on_dosage_id", using: :btree
  add_index "instructions", ["interval_unit_cd"], name: "index_instructions_on_interval_unit_cd", using: :btree
  add_index "instructions", ["interval_value"], name: "index_instructions_on_interval_value", using: :btree

  create_table "medical_records", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "dob"
    t.integer  "gender_cd"
    t.integer  "blood_type_cd"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "medical_records", ["blood_type_cd"], name: "index_medical_records_on_blood_type_cd", using: :btree
  add_index "medical_records", ["gender_cd"], name: "index_medical_records_on_gender_cd", using: :btree
  add_index "medical_records", ["user_id"], name: "index_medical_records_on_user_id", using: :btree

  create_table "organization_users", force: :cascade do |t|
    t.integer  "role_cd",         null: false
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_users", ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
  add_index "organization_users", ["user_id"], name: "index_organization_users_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",               null: false
    t.integer  "nationality_cd",     null: false
    t.integer  "primary_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["primary_address_id"], name: "index_organizations_on_primary_address_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prescriptions", force: :cascade do |t|
    t.text     "description"
    t.integer  "condition_id"
    t.integer  "consultation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "prescriptions", ["condition_id"], name: "index_prescriptions_on_condition_id", using: :btree
  add_index "prescriptions", ["consultation_id"], name: "index_prescriptions_on_consultation_id", using: :btree

  create_table "professions", force: :cascade do |t|
    t.integer  "industry_cd", null: false
    t.string   "title",       null: false
    t.text     "description"
    t.boolean  "verified",    null: false
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "professions", ["user_id"], name: "index_professions_on_user_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "city"
    t.string   "unit"
    t.integer  "value"
    t.integer  "type_cd"
    t.integer  "category_cd"
    t.integer  "sub_category_cd"
    t.integer  "country_cd"
    t.integer  "user_id"
    t.integer  "resourceable_id"
    t.string   "resourceable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["category_cd"], name: "index_resources_on_category_cd", using: :btree
  add_index "resources", ["country_cd"], name: "index_resources_on_country_cd", using: :btree
  add_index "resources", ["sub_category_cd"], name: "index_resources_on_sub_category_cd", using: :btree
  add_index "resources", ["type_cd"], name: "index_resources_on_type_cd", using: :btree
  add_index "resources", ["user_id"], name: "index_resources_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "display_name"
    t.string   "uuid"
    t.string   "access_token"
    t.string   "roles",                  default: [], null: false, array: true
    t.integer  "marital_status_cd"
    t.integer  "nationality_cd"
    t.integer  "primary_address_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["primary_address_id"], name: "index_users_on_primary_address_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["roles"], name: "index_users_on_roles", using: :gin
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vision_records", force: :cascade do |t|
    t.string   "DV_OD_SPH"
    t.string   "DV_OS_SPH"
    t.string   "DV_OD_CYL"
    t.string   "DV_OS_CYL"
    t.string   "DV_OD_AXIS"
    t.string   "DV_OS_AXIS"
    t.string   "NV_OD_SPH"
    t.string   "NV_OS_SPH"
    t.string   "NV_OD_CYL"
    t.string   "NV_OS_CYL"
    t.string   "NV_OD_AXIS"
    t.string   "NV_OS_AXIS"
    t.string   "PD"
    t.integer  "exam_date"
    t.integer  "expiration_date"
    t.integer  "medical_record_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
