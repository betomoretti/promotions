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

ActiveRecord::Schema.define(version: 20150610143214) do

  create_table "coefficients", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "active",         default: true
    t.integer  "credit_card_id"
    t.integer  "condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coefficients", ["condition_id"], name: "index_coefficients_on_condition_id", using: :btree
  add_index "coefficients", ["credit_card_id"], name: "index_coefficients_on_credit_card_id", using: :btree

  create_table "conditions", force: true do |t|
    t.string   "shortname"
    t.string   "legal_description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "active",            default: true
    t.integer  "airline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conditions", ["airline_id"], name: "index_conditions_on_airline_id", using: :btree

  create_table "credit_cards", force: true do |t|
    t.string   "name"
    t.integer  "quantity_digits"
    t.integer  "bin_start"
    t.integer  "quantity_code_security"
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", force: true do |t|
    t.string   "quota"
    t.string   "bin"
    t.string   "commerce_number"
    t.string   "observations"
    t.string   "observationsb2c"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "bank_id"
    t.integer  "credit_card_id"
    t.integer  "condition_id"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promotions", ["bank_id"], name: "index_promotions_on_bank_id", using: :btree
  add_index "promotions", ["condition_id"], name: "index_promotions_on_condition_id", using: :btree
  add_index "promotions", ["credit_card_id"], name: "index_promotions_on_credit_card_id", using: :btree

  create_table "values", force: true do |t|
    t.string   "quota"
    t.decimal  "value",          precision: 10, scale: 0
    t.integer  "coefficient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "values", ["coefficient_id"], name: "index_values_on_coefficient_id", using: :btree

end
