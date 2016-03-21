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

ActiveRecord::Schema.define(version: 20160319125541) do

  create_table "jquest_pg_territories", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_teachers", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "school_teachers", ["school_id"], name: "index_school_teachers_on_school_id"
  add_index "school_teachers", ["user_id"], name: "index_school_teachers_on_user_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "contact_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",           default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep",         default: 0,     null: false
    t.boolean  "otp_required_for_login",    default: false, null: false
    t.string   "role",                      default: "",    null: false
    t.string   "phone_number",              default: "",    null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid"
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
