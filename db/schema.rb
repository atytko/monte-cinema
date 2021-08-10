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

ActiveRecord::Schema.define(version: 2021_08_09_192344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cinema_halls", force: :cascade do |t|
    t.string "name", null: false
    t.integer "row_total_seats", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "row_number", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "duration", null: false
    t.string "genre", null: false
    t.string "director", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "screening_id", null: false
    t.bigint "user_id"
    t.bigint "ticket_desk_id"
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["screening_id"], name: "index_reservations_on_screening_id"
    t.index ["ticket_desk_id"], name: "index_reservations_on_ticket_desk_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.datetime "screening_time", null: false
    t.bigint "cinema_hall_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_hall_id"], name: "index_screenings_on_cinema_hall_id"
    t.index ["movie_id"], name: "index_screenings_on_movie_id"
  end

  create_table "seats_reservations", force: :cascade do |t|
    t.string "row", null: false
    t.integer "seat_number", null: false
    t.bigint "reservation_id", null: false
    t.bigint "cinema_hall_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_hall_id"], name: "index_seats_reservations_on_cinema_hall_id"
    t.index ["reservation_id"], name: "index_seats_reservations_on_reservation_id"
  end

  create_table "ticket_desks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "ticket_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_tickets_on_reservation_id"
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "email"
    t.json "tokens"
    t.bigint "user_role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  create_table "users_ticket_desks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_desk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_desk_id"], name: "index_users_ticket_desks_on_ticket_desk_id"
    t.index ["user_id"], name: "index_users_ticket_desks_on_user_id"
  end

end
