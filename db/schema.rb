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

ActiveRecord::Schema.define(version: 2019_08_30_092638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "photo"
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_events", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "actor_id"
    t.bigint "target_id"
    t.string "event_type"
    t.integer "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_game_events_on_actor_id"
    t.index ["game_id"], name: "index_game_events_on_game_id"
    t.index ["target_id"], name: "index_game_events_on_target_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "round"
    t.string "step"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "round_step"
    t.text "news"
  end

  create_table "lover_couples", force: :cascade do |t|
    t.bigint "lover1_id"
    t.bigint "lover2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.index ["game_id"], name: "index_lover_couples_on_game_id"
    t.index ["lover1_id"], name: "index_lover_couples_on_lover1_id"
    t.index ["lover2_id"], name: "index_lover_couples_on_lover2_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "player_id"
    t.text "content"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_messages_on_game_id"
    t.index ["player_id"], name: "index_messages_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "character_id"
    t.boolean "is_alive"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.boolean "is_link"
    t.string "state_chasseur"
    t.index ["character_id"], name: "index_players_on_character_id"
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "description"
    t.string "picture"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_events", "games"
  add_foreign_key "game_events", "players", column: "actor_id"
  add_foreign_key "game_events", "players", column: "target_id"
  add_foreign_key "lover_couples", "games"
  add_foreign_key "lover_couples", "users", column: "lover1_id"
  add_foreign_key "lover_couples", "users", column: "lover2_id"
  add_foreign_key "messages", "games"
  add_foreign_key "messages", "players"
  add_foreign_key "players", "characters"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
end
