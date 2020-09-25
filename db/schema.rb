# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_25_174113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "applications", force: :cascade do |t|
    t.string "status"
    t.string "external_id"
    t.bigint "lead_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount"
    t.integer "down_payment"
    t.integer "discount_cents"
    t.string "discount_currency", default: "BRL", null: false
    t.integer "down_payment_cents"
    t.string "down_payment_currency", default: "BRL", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_applications_on_company_id"
    t.index ["lead_id"], name: "index_applications_on_lead_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contract_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contract_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_events_on_contract_id"
    t.index ["type"], name: "index_contract_events_on_type"
  end

  create_table "contract_signers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contract_id"
    t.string "provider"
    t.string "provider_id"
    t.string "person_id"
    t.string "cpf"
    t.string "email"
    t.string "phone_number"
    t.string "provider_request_signature_key"
    t.string "sign_type"
    t.datetime "request_signature_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "signed_at"
    t.index ["contract_id"], name: "index_contract_signers_on_contract_id"
  end

  create_table "contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "external_type"
    t.string "external_id"
    t.string "product_name", default: "AUTO_FIN"
    t.string "provider", default: "CLICKSIGN"
    t.string "source_id"
    t.string "template_id"
    t.string "ccb_number"
    t.string "status", default: "CREATED"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_type", "external_id"], name: "index_contracts_on_external_type_and_external_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "know_your_customer_field_errors", force: :cascade do |t|
    t.string "field"
    t.bigint "application_id"
    t.index ["application_id"], name: "index_know_your_customer_field_errors_on_application_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rfc"
    t.bigint "model_id"
    t.bigint "version_id"
    t.integer "auto_year"
    t.float "auto_price"
    t.float "down_payment"
    t.uuid "user_id"
    t.float "loan_amount"
    t.integer "term"
    t.integer "purpose"
    t.boolean "is_paid"
    t.integer "source", default: 0
    t.index ["model_id"], name: "index_leads_on_model_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
    t.index ["version_id"], name: "index_leads_on_version_id"
  end

  create_table "log_know_your_customer_requests", force: :cascade do |t|
    t.bigint "application_id"
    t.string "response"
    t.index ["application_id"], name: "index_log_know_your_customer_requests_on_application_id"
  end

  create_table "makes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "make_id"
    t.index ["make_id"], name: "index_models_on_make_id"
  end

  create_table "payments", force: :cascade do |t|
    t.uuid "contract_id"
    t.string "external_type"
    t.string "external_id"
    t.string "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_payments_on_contract_id"
    t.index ["external_type", "external_id"], name: "index_payments_on_external_type_and_external_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "finished_at"
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_steps_on_application_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "original_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "role"
    t.string "username"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "model_id"
    t.index ["model_id"], name: "index_versions_on_model_id"
  end

  add_foreign_key "applications", "companies"
  add_foreign_key "applications", "leads"
  add_foreign_key "contract_events", "contracts"
  add_foreign_key "contract_signers", "contracts"
  add_foreign_key "know_your_customer_field_errors", "applications"
  add_foreign_key "log_know_your_customer_requests", "applications"
  add_foreign_key "payments", "contracts"
  add_foreign_key "steps", "applications"
end
