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

ActiveRecord::Schema.define(version: 20160803070832) do

  create_table "dongs", force: :cascade do |t|
    t.integer  "univ_id"
    t.string   "gender"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dongs", ["univ_id"], name: "index_dongs_on_univ_id"

  create_table "periods", force: :cascade do |t|
    t.integer  "univ_id"
    t.string   "name"
    t.boolean  "in_progress"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "periods", ["univ_id"], name: "index_periods_on_univ_id"

  create_table "preference_surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sociality"
    t.integer  "familiarity"
    t.integer  "awaken"
    t.integer  "smoke"
    t.integer  "game"
    t.integer  "waketime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "preference_surveys", ["user_id"], name: "index_preference_surveys_on_user_id"

  create_table "surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sociality"
    t.integer  "familiarity"
    t.integer  "awaken"
    t.integer  "smoke"
    t.integer  "game"
    t.integer  "waketime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id"

  create_table "univs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "name"
    t.string   "gender"
    t.string   "major"
    t.string   "birth"
    t.string   "stage"
    t.integer  "univ_id"
    t.integer  "dong1_id"
    t.integer  "dong2_id"
    t.integer  "period1_id"
    t.integer  "period2_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["dong1_id"], name: "index_users_on_dong1_id"
  add_index "users", ["dong2_id"], name: "index_users_on_dong2_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["period1_id"], name: "index_users_on_period1_id"
  add_index "users", ["period2_id"], name: "index_users_on_period2_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["univ_id"], name: "index_users_on_univ_id"

end
