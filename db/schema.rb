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

ActiveRecord::Schema.define(version: 2022_02_12_051049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "current_product_goals", force: :cascade do |t|
    t.uuid "product_goal_id"
    t.uuid "product_backlog_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_backlog_id"], name: "index_current_product_goals_on_product_backlog_id"
    t.index ["product_goal_id", "product_backlog_id"], name: "unique_key_curernt_product_goals", unique: true
    t.index ["product_goal_id"], name: "index_current_product_goals_on_product_goal_id"
  end

  create_table "product_backlog_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_backlog_id"
    t.uuid "work_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_backlog_id"], name: "index_product_backlog_items_on_product_backlog_id"
    t.index ["work_id"], name: "index_product_backlog_items_on_work_id"
  end

  create_table "product_backlogs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.datetime "updated_at", precision: 6
    t.index ["product_id"], name: "index_product_backlogs_on_product_id", unique: true
  end

  create_table "product_goals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.string "content", null: false
    t.boolean "achieved", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_goals_on_product_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "vision", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "works", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "product_goal_id"
    t.integer "number", null: false
    t.integer "status", default: 0, null: false
    t.string "description", null: false
    t.integer "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_goal_id"], name: "index_works_on_product_goal_id"
    t.index ["product_id", "number"], name: "index_works_on_product_id_and_number", unique: true
    t.index ["product_id"], name: "index_works_on_product_id"
  end

  add_foreign_key "current_product_goals", "product_backlogs"
  add_foreign_key "current_product_goals", "product_goals"
  add_foreign_key "product_backlog_items", "product_backlogs"
  add_foreign_key "product_backlog_items", "works"
  add_foreign_key "product_backlogs", "products"
  add_foreign_key "product_goals", "products"
  add_foreign_key "works", "product_goals"
  add_foreign_key "works", "products"
end
