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

ActiveRecord::Schema.define(version: 2019_06_12_145428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.string "country_code"
    t.string "city"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telephone"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "country"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "specialty_id"
    t.boolean "publish", default: false
    t.bigint "user_id"
    t.index ["specialty_id"], name: "index_vacancies_on_specialty_id"
    t.index ["user_id"], name: "index_vacancies_on_user_id"
  end

  create_table "vacancy_attributes", force: :cascade do |t|
    t.string "attr_type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vacancy_id"
    t.boolean "important", default: false
    t.index ["vacancy_id"], name: "index_vacancy_attributes_on_vacancy_id"
  end

  create_table "vacancy_specialties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "vacancies", "users"
  add_foreign_key "vacancies", "vacancy_specialties", column: "specialty_id"
  add_foreign_key "vacancy_attributes", "vacancies"
end
