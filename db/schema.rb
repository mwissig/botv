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

ActiveRecord::Schema.define(version: 2020_04_15_140850) do

  create_table "bulbs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bulbable_id"
    t.string "color"
    t.string "bulbable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.integer "parent_id"
    t.string "parent_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "sort", default: 1
    t.integer "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "is_admin", default: false
    t.boolean "is_mod", default: false
    t.boolean "can_post_video", default: true
    t.boolean "can_comment", default: true
    t.boolean "can_bulb", default: true
    t.datetime "video_ban_end"
    t.datetime "comment_ban_end"
    t.datetime "bulb_ban_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason_for_ban"
    t.boolean "is_horny"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "description"
    t.string "category1"
    t.string "category2"
    t.string "tags"
    t.integer "plays", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "brief"
    t.integer "rating"
    t.text "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.integer "user_id"
    t.string "id_code"
    t.string "provider"
    t.string "title"
    t.integer "duration"
    t.text "description"
    t.string "thumbnail"
    t.string "embed_url"
    t.string "embed_code"
    t.string "tags"
    t.string "category1"
    t.string "category2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plays", default: 0
  end

end
