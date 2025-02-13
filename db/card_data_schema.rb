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

ActiveRecord::Schema[8.0].define(version: 2025_01_13_020329) do
  create_table "arenas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.index ["name"], name: "index_arenas_on_name", unique: true
  end

  create_table "aspects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "color"
    t.integer "sort_order"
    t.index ["name"], name: "index_aspects_on_name", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.integer "swuid"
    t.integer "swu_cardid"
    t.string "title"
    t.string "subtitle"
    t.integer "number"
    t.string "set_code"
    t.string "artist"
    t.string "url"
    t.index ["set_code"], name: "index_cards_on_set_code"
    t.index ["swuid", "swu_cardid"], name: "index_cards_on_swuid_and_swu_cardid", unique: true
  end

  create_table "expansions", force: :cascade do |t|
    t.string "code"
    t.string "title"
    t.date "released_on"
    t.integer "sort_order"
    t.index ["code"], name: "index_expansions_on_code", unique: true
  end

  create_table "rarities", force: :cascade do |t|
    t.string "name"
    t.string "character"
    t.string "color"
    t.integer "sort_order"
    t.index ["name"], name: "index_rarities_on_name", unique: true
  end

  create_table "traits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.index ["name"], name: "index_traits_on_name", unique: true
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "sort_order"
    t.index ["name"], name: "index_types_on_name", unique: true
  end
end
