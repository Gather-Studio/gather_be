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

ActiveRecord::Schema.define(version: 2023_01_20_175924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "glazes", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_glazes", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "glaze_id"
    t.integer "layers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glaze_id"], name: "index_item_glazes_on_glaze_id"
    t.index ["item_id"], name: "index_item_glazes_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "style"
    t.integer "status"
    t.string "clay_body"
    t.float "height"
    t.float "width"
    t.string "memo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "api_key"
  end

  add_foreign_key "item_glazes", "glazes"
  add_foreign_key "item_glazes", "items"
  add_foreign_key "items", "users"
end
