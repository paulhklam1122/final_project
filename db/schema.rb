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

ActiveRecord::Schema.define(version: 20160816033304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "bank_name"
    t.string   "account_type"
    t.float    "account_balance"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "card_name"
    t.float    "monthly_balance"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "expense_name"
    t.float    "amount"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_expenses_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_follows_on_goal_id", using: :btree
    t.index ["user_id"], name: "index_follows_on_user_id", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.string   "goal_name"
    t.float    "amount"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "mark",       default: "Not Achieved"
    t.string   "image"
    t.string   "location"
    t.float    "longitude"
    t.float    "latitude"
    t.index ["user_id"], name: "index_goals_on_user_id", using: :btree
  end

  create_table "loan_accounts", force: :cascade do |t|
    t.string   "loan_name"
    t.float    "balance"
    t.float    "monthly_payment"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_loan_accounts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "avatar"
    t.float    "income"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.float    "value"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_properties_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "google_token"
    t.string   "google_secret"
    t.string   "google_raw_data"
    t.string   "facebook_token"
    t.string   "facebook_secret"
    t.string   "facebook_raw_data"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", using: :btree
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "expenses", "users"
  add_foreign_key "follows", "goals"
  add_foreign_key "follows", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "loan_accounts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "properties", "users"
end
