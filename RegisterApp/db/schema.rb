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

ActiveRecord::Schema.define(version: 2020_12_08_034650) do

  create_table "carts", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "productCount", default: 0, null: false
    t.integer "total", default: 0, null: false
    t.text "cart", default: "{}", null: false
    t.index ["employee_id"], name: "index_carts_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "employeeId", null: false
    t.string "password_digest", default: "", null: false
    t.string "firstName", default: "", null: false
    t.string "lastName", default: "", null: false
    t.boolean "active", default: false
    t.integer "classification", null: false
    t.integer "manager_id", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active"], name: "index_employees_on_active"
    t.index ["employeeId"], name: "index_employees_on_employeeId", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "lookupCode", default: "", null: false
    t.integer "count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lookupCode"], name: "index_products_on_lookupCode", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "productCount", default: 0, null: false
    t.integer "total", default: 0, null: false
    t.text "trans", default: "{}", null: false
    t.index ["employee_id"], name: "index_transactions_on_employee_id"
  end

end
