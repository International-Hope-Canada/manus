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

ActiveRecord::Schema[8.1].define(version: 2026_01_18_213045) do
  create_table "containers", force: :cascade do |t|
    t.integer "application_number", null: false
    t.string "consignee_address"
    t.string "consignee_city"
    t.string "consignee_contact_email"
    t.string "consignee_contact_name"
    t.string "consignee_contact_phone"
    t.string "consignee_country"
    t.string "consignee_name"
    t.string "consignee_postal_code"
    t.string "consignee_region"
    t.datetime "created_at", null: false
    t.date "shipped_at"
    t.datetime "updated_at", null: false
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "barcode", limit: 10, null: false
    t.integer "container_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "inventoried_by_id", null: false
    t.integer "item_subcategory_id", null: false
    t.integer "manual_type", default: 0, null: false
    t.integer "oldest_expiry_year"
    t.datetime "picked_at"
    t.integer "picked_by_id"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["barcode"], name: "index_inventory_items_on_barcode", unique: true
    t.index ["inventoried_by_id"], name: "index_inventory_items_on_inventoried_by_id"
    t.index ["item_subcategory_id"], name: "index_inventory_items_on_item_subcategory_id"
  end

  create_table "item_categories", force: :cascade do |t|
    t.integer "classification", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.decimal "value", precision: 10, scale: 2
    t.decimal "weight_kg", precision: 10, scale: 1
    t.index ["name", "classification"], name: "index_item_categories_on_name_and_classification", unique: true
  end

  create_table "item_subcategories", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.integer "item_category_id", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.decimal "value", precision: 10, scale: 2
    t.decimal "weight_kg", precision: 10, scale: 1
    t.index ["item_category_id"], name: "index_item_subcategories_on_item_category_id"
    t.index ["name", "item_category_id"], name: "index_item_subcategories_on_name_and_item_category_id", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.string "setting_key", limit: 20, null: false
    t.string "setting_value", limit: 1000
    t.index ["setting_key"], name: "index_settings_on_setting_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "first_name", null: false
    t.string "initials", limit: 3, null: false
    t.string "last_name", null: false
    t.boolean "packer", default: false, null: false
    t.boolean "picker", default: false, null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name"], name: "index_users_on_first_name_and_last_name", unique: true
    t.index ["initials"], name: "index_users_on_initials", unique: true
  end

  add_foreign_key "inventory_items", "containers"
  add_foreign_key "inventory_items", "item_subcategories"
  add_foreign_key "inventory_items", "users", column: "inventoried_by_id"
  add_foreign_key "inventory_items", "users", column: "picked_by_id"
  add_foreign_key "item_subcategories", "item_categories"
end
