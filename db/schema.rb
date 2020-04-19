# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_19_111825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.string "title"
    t.string "plot"
    t.bigint "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num_episode"
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.datetime "expired_time"
    t.boolean "active"
    t.string "libraryable_type"
    t.bigint "libraryable_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["libraryable_type", "libraryable_id"], name: "index_libraries_on_libraryable_type_and_libraryable_id"
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "plot"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.decimal "price"
    t.string "video_quality"
    t.string "purchaseable_type"
    t.bigint "purchaseable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchaseable_type", "purchaseable_id"], name: "index_purchases_on_purchaseable_type_and_purchaseable_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title"
    t.string "plot"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "auth_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "episodes", "seasons"
  add_foreign_key "libraries", "users"
end
