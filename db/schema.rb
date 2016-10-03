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

ActiveRecord::Schema.define(version: 20161003133144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "season_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "points",        default: 0
    t.string   "taxonomy"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "value"
    t.integer  "assignment_id"
    t.index ["assignment_id"], name: "index_activities_on_assignment_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "fk__activities_resource_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_activities_on_resource_type_and_resource_id", using: :btree
    t.index ["season_id"], name: "index_activities_on_season_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.integer  "season_id",                         null: false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "expires_at"
    t.string   "label"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "status",        default: "pending", null: false
    t.integer  "level"
    t.index ["expires_at"], name: "index_assignments_on_expires_at", using: :btree
    t.index ["season_id"], name: "index_assignments_on_season_id", using: :btree
    t.index ["user_id"], name: "index_assignments_on_user_id", using: :btree
  end

  create_table "course_materials", force: :cascade do |t|
    t.string   "title"
    t.string   "state_name"
    t.text     "state_params", default: "{}"
    t.text     "body"
    t.string   "status",       default: "draft", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "category"
    t.integer  "position",     default: 0
    t.index ["state_name"], name: "index_course_materials_on_state_name", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["season_id"], name: "index_groups_on_season_id", using: :btree
  end

  create_table "jquest_pg_diversities", force: :cascade do |t|
    t.integer  "resource_a_id"
    t.string   "resource_a_type"
    t.integer  "resource_b_id"
    t.string   "resource_b_type"
    t.integer  "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "jquest_pg_legislatures", force: :cascade do |t|
    t.string   "name"
    t.string   "name_english"
    t.string   "name_local"
    t.string   "territory"
    t.integer  "difficulty_level"
    t.string   "country",           limit: 3
    t.date     "start_date"
    t.date     "end_date"
    t.string   "source"
    t.string   "list"
    t.integer  "number_of_members"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "languages"
  end

  create_table "jquest_pg_mandatures", force: :cascade do |t|
    t.integer  "legislature_id"
    t.integer  "person_id"
    t.string   "political_leaning"
    t.string   "role"
    t.string   "group"
    t.string   "area"
    t.string   "chamber"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "age_range"
    t.index ["legislature_id", "person_id"], name: "index_jquest_pg_mandatures_on_legislature_id_and_person_id", unique: true, using: :btree
    t.index ["legislature_id"], name: "index_jquest_pg_mandatures_on_legislature_id", using: :btree
    t.index ["person_id"], name: "index_jquest_pg_mandatures_on_person_id", using: :btree
  end

  create_table "jquest_pg_people", force: :cascade do |t|
    t.string   "fullname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "education"
    t.string   "profession_category"
    t.string   "profession"
    t.string   "image"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "birthplace"
    t.string   "phone"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "diversity_positive",  default: 0
    t.integer  "diversity_count",     default: 0
  end

  create_table "points", force: :cascade do |t|
    t.integer "user_id"
    t.integer "season_id"
    t.integer "value",     default: 0
    t.integer "level",     default: 1
    t.integer "round",     default: 1
    t.index ["season_id"], name: "index_points_on_season_id", using: :btree
    t.index ["user_id", "season_id"], name: "index_points_on_user_id_and_season_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_points_on_user_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "contact_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "country",       limit: 3
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.string   "primary_color",          default: "#373a3c"
    t.string   "status",                 default: "open"
    t.string   "engine_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "invitation_description"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "field"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.text     "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_type", "resource_id", "field"], name: "index_sources_on_resource_type_and_resource_id_and_field", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                               default: "",    null: false
    t.string   "encrypted_password",                  default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                     default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep",                   default: 0,     null: false
    t.boolean  "otp_required_for_login",              default: false, null: false
    t.string   "role",                                default: "",    null: false
    t.string   "phone_number",                        default: "",    null: false
    t.integer  "school_id"
    t.integer  "group_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                   default: 0
    t.string   "home_country",              limit: 3
    t.string   "spoken_language"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "invited_to_channel_at"
    t.string   "invited_to_channel_as",               default: ""
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["group_id"], name: "index_users_on_group_id", using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["provider"], name: "index_users_on_provider", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["school_id"], name: "index_users_on_school_id", using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "activities", "seasons", name: "fk_activities_season_id"
  add_foreign_key "activities", "users", name: "fk_activities_user_id"
  add_foreign_key "assignments", "seasons"
  add_foreign_key "assignments", "users"
  add_foreign_key "jquest_pg_mandatures", "jquest_pg_legislatures", column: "legislature_id", name: "fk_jquest_pg_mandatures_legislature_id"
  add_foreign_key "jquest_pg_mandatures", "jquest_pg_people", column: "person_id", name: "fk_jquest_pg_mandatures_person_id"
  add_foreign_key "points", "seasons"
  add_foreign_key "points", "users"
end
