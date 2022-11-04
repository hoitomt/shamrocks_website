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

ActiveRecord::Schema.define(version: 2022_11_04_023028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "player_registrations", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.boolean "need_uniform"
    t.string "uniform_jersey_size"
    t.string "uniform_short_size"
    t.decimal "amount", precision: 8, scale: 2
    t.string "charge_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "parent_first_name"
    t.string "parent_last_name"
    t.string "email"
    t.string "gender"
    t.integer "graduation_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string "player_first_name"
    t.string "player_last_name"
    t.string "parent_first_name"
    t.string "parent_last_name"
    t.string "email"
    t.string "grade_level"
    t.integer "graduation_year"
    t.boolean "need_uniform"
    t.string "uniform_jersey_size"
    t.string "uniform_short_size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount", precision: 8, scale: 2
    t.string "charge_identifier"
    t.string "team_gender"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "graduation_year"
    t.integer "school_year_start"
    t.integer "grade_level"
    t.string "gender"
    t.string "coach_first_name"
    t.string "coach_last_name"
    t.string "coach_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "waivers", force: :cascade do |t|
    t.integer "registration_id"
    t.boolean "confirmation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
