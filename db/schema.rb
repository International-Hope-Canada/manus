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

ActiveRecord::Schema[8.1].define(version: 2025_12_24_011918) do
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
    t.datetime "created_at", null: false
    t.integer "item_category_id", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.decimal "value", precision: 10, scale: 2
    t.decimal "weight_kg", precision: 10, scale: 1
    t.index ["item_category_id"], name: "index_item_subcategories_on_item_category_id"
    t.index ["name", "item_category_id"], name: "index_item_subcategories_on_name_and_item_category_id", unique: true
  end

  add_foreign_key "item_subcategories", "item_categories"
end
