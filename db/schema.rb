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

ActiveRecord::Schema.define(version: 2022_04_12_095304) do

  create_table "advices", charset: "utf8mb4", force: :cascade do |t|
    t.string "phonetic_symbol"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", charset: "utf8mb4", force: :cascade do |t|
    t.string "english_text", null: false
    t.string "meaning"
    t.integer "phase", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ranks", charset: "utf8mb4", force: :cascade do |t|
    t.string "evaluation", null: false
    t.string "message", null: false
    t.float "max_for_each", null: false
    t.float "min_for_each", null: false
    t.integer "max_for_total", null: false
    t.integer "min_for_total", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recording_results", charset: "utf8mb4", force: :cascade do |t|
    t.string "recognized_english", null: false
    t.float "average_score", null: false
    t.float "accuracy_score", null: false
    t.float "fluency_score", null: false
    t.float "completeness_score", null: false
    t.datetime "start_time", null: false
    t.bigint "question_id", null: false
    t.bigint "total_result_id", null: false
    t.bigint "rank_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_recording_results_on_question_id"
    t.index ["rank_id"], name: "index_recording_results_on_rank_id"
    t.index ["total_result_id"], name: "index_recording_results_on_total_result_id"
  end

  create_table "total_results", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "rank_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rank_id"], name: "index_total_results_on_rank_id"
    t.index ["user_id"], name: "index_total_results_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "user_digest", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "recording_results", "questions"
  add_foreign_key "recording_results", "ranks"
  add_foreign_key "recording_results", "total_results"
  add_foreign_key "total_results", "ranks"
  add_foreign_key "total_results", "users"
end
