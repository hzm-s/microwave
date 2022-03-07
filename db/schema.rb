# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_07_101550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "active_user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active_user_id", "provider"], name: "index_accounts_on_active_user_id_and_provider", unique: true
    t.index ["active_user_id"], name: "index_accounts_on_active_user_id"
    t.index ["provider", "uid"], name: "index_accounts_on_provider_and_uid"
  end

  create_table "active_users", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "initials", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_active_users_on_email", unique: true
    t.index ["user_id"], name: "index_active_users_on_user_id"
    t.index ["user_id"], name: "unique_key_active_users_on_user_id", unique: true
  end

  create_table "cancelled_users", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "cancelled_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cancelled_users_on_user_id"
  end

  create_table "product_goals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_goals_on_product_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "vision", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "active_users"
  add_foreign_key "active_users", "users"
  add_foreign_key "cancelled_users", "users"
  add_foreign_key "product_goals", "products"
end
