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

ActiveRecord::Schema.define(version: 2021_02_03_204045) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "img_path"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "img_path"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "img_path"
    t.string "color"
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string "code"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "value_in_percent"
    t.integer "value_in_cash"
    t.boolean "value_in_shipping"
    t.integer "required_value"
  end

  create_table "miscs", force: :cascade do |t|
    t.integer "value"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "msgs", force: :cascade do |t|
    t.string "msg"
    t.string "subject"
    t.string "email"
    t.string "lastname"
    t.string "firstname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone"
    t.boolean "read"
  end

  create_table "orderd_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "value"
    t.string "address"
    t.string "city"
    t.string "email"
    t.string "phone"
    t.string "firstname"
    t.string "lastname"
    t.string "postal"
    t.string "tracking"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "discount_id"
    t.integer "shipping_cost"
    t.string "status"
  end

  create_table "products", force: :cascade do |t|
    t.string "size"
    t.string "desc"
    t.integer "color_id"
    t.integer "price"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "brand_id"
    t.integer "category_id"
    t.boolean "bought"
    t.integer "old_price"
    t.integer "quality_id"
    t.integer "order_id"
  end

  create_table "qualities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "grade"
  end

  create_table "sell_requests", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "brand"
    t.string "condition"
    t.string "file_path"
    t.string "asking_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "product_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
