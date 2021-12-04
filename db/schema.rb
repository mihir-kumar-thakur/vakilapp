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

ActiveRecord::Schema.define(version: 2021_12_03_140523) do

  create_table "advocate_cases", force: :cascade do |t|
    t.integer "advocate_id"
    t.integer "case_id"
    t.string "status"
  end

  create_table "advocate_states", force: :cascade do |t|
    t.integer "advocate_id"
    t.integer "state_id"
  end

  create_table "advocates", force: :cascade do |t|
    t.string "code"
    t.string "position"
    t.integer "senior_id"
    t.index ["code"], name: "index_advocates_on_code", unique: true
  end

  create_table "cases", force: :cascade do |t|
    t.string "case_code"
    t.integer "state_id"
    t.index ["case_code"], name: "index_cases_on_case_code", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_states_on_name", unique: true
  end

end
