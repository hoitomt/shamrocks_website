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

ActiveRecord::Schema.define(version: 2020_09_22_040619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
