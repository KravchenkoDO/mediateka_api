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

ActiveRecord::Schema.define(version: 2021_07_12_081621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "actors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_name"], name: "index_actors_on_last_name"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "genres", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_genres_on_title"
  end

  create_table "movie_actors", force: :cascade do |t|
    t.bigint "movies_id"
    t.bigint "actors_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actors_id"], name: "index_movie_actors_on_actors_id"
    t.index ["movies_id"], name: "index_movie_actors_on_movies_id"
  end

  create_table "movie_companies", force: :cascade do |t|
    t.bigint "movies_id"
    t.bigint "companies_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["companies_id"], name: "index_movie_companies_on_companies_id"
    t.index ["movies_id"], name: "index_movie_companies_on_movies_id"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.bigint "movies_id"
    t.bigint "genres_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genres_id"], name: "index_movie_genres_on_genres_id"
    t.index ["movies_id"], name: "index_movie_genres_on_movies_id"
  end

  create_table "movie_producers", force: :cascade do |t|
    t.bigint "movies_id"
    t.bigint "producers_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movies_id"], name: "index_movie_producers_on_movies_id"
    t.index ["producers_id"], name: "index_movie_producers_on_producers_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.bigint "posters_id"
    t.string "age_limit"
    t.integer "budget"
    t.integer "box_office"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["posters_id"], name: "index_movies_on_posters_id"
    t.index ["title"], name: "index_movies_on_title"
  end

  create_table "posters", force: :cascade do |t|
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "producers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_name"], name: "index_producers_on_last_name"
  end

  create_table "user_favorite_movies", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "movies_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movies_id"], name: "index_user_favorite_movies_on_movies_id"
    t.index ["users_id"], name: "index_user_favorite_movies_on_users_id"
  end

  create_table "user_follow_genres", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "genres_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genres_id"], name: "index_user_follow_genres_on_genres_id"
    t.index ["users_id"], name: "index_user_follow_genres_on_users_id"
  end

  create_table "user_movie_comments", force: :cascade do |t|
    t.bigint "movies_id"
    t.bigint "users_id"
    t.string "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rating"
    t.index ["movies_id"], name: "index_user_movie_comments_on_movies_id"
    t.index ["users_id"], name: "index_user_movie_comments_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.integer "role", default: 0, null: false
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "movie_actors", "actors", column: "actors_id"
  add_foreign_key "movie_actors", "movies", column: "movies_id"
  add_foreign_key "movie_companies", "companies", column: "companies_id"
  add_foreign_key "movie_companies", "movies", column: "movies_id"
  add_foreign_key "movie_genres", "genres", column: "genres_id"
  add_foreign_key "movie_genres", "movies", column: "movies_id"
  add_foreign_key "movie_producers", "movies", column: "movies_id"
  add_foreign_key "movie_producers", "producers", column: "producers_id"
  add_foreign_key "movies", "posters", column: "posters_id"
  add_foreign_key "user_favorite_movies", "movies", column: "movies_id"
  add_foreign_key "user_favorite_movies", "users", column: "users_id"
  add_foreign_key "user_follow_genres", "genres", column: "genres_id"
  add_foreign_key "user_follow_genres", "users", column: "users_id"
  add_foreign_key "user_movie_comments", "movies", column: "movies_id"
  add_foreign_key "user_movie_comments", "users", column: "users_id"
end
