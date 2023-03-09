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

ActiveRecord::Schema[7.0].define(version: 2023_03_07_135901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.text "diagnostic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "general_practitioner_user_id"
    t.bigint "cardiologist_user_id"
    t.index ["cardiologist_user_id"], name: "index_consultations_on_cardiologist_user_id"
    t.index ["general_practitioner_user_id"], name: "index_consultations_on_general_practitioner_user_id"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "ecgs", force: :cascade do |t|
    t.text "data"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_ecgs_on_patient_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.index ["consultation_id"], name: "index_messages_on_consultation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birth_date"
    t.integer "height"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone"
    t.integer "speciality"
    t.string "doctolib_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "patients"
  add_foreign_key "consultations", "users", column: "cardiologist_user_id"
  add_foreign_key "consultations", "users", column: "general_practitioner_user_id"
  add_foreign_key "ecgs", "patients"
  add_foreign_key "messages", "consultations"
  add_foreign_key "messages", "users"
end
