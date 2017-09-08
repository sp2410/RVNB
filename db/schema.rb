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

ActiveRecord::Schema.define(version: 20170907090520) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_notifications", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "startdate"
    t.datetime "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "listing_id"
    t.index ["listing_id"], name: "index_availabilities_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "year"
    t.integer "length"
    t.integer "sleeps"
    t.integer "rateperhour"
    t.string "vehicletype"
    t.integer "rentalminimum"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "imagefront"
    t.string "imageback"
    t.string "imageleft"
    t.string "imageright"
    t.string "interiorfront"
    t.string "interiorback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street"
    t.string "state"
    t.string "zipcode"
    t.integer "user_id"
    t.string "pickup_street_address"
    t.string "pickup_city"
    t.string "pickup_state"
    t.string "pickup_zipcode"
    t.integer "extra_guest_charges"
    t.integer "maximum_guest_allowed"
    t.index ["user_id"], name: "original_user"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "send_to"
  end

  create_table "payments", force: :cascade do |t|
    t.string "paypal_email"
    t.string "bank_account_number"
    t.string "bank_routing_number"
    t.string "billing_name"
    t.string "billing_street_address"
    t.string "billing_city"
    t.string "billing_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "contact_number"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "status"
    t.datetime "endate"
    t.integer "numberofguests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "listing_id"
    t.time "start_time"
    t.time "end_time"
    t.float "total_cost"
    t.date "booking_date"
    t.integer "availability_id"
    t.integer "user_id"
    t.boolean "reviwed", default: false
    t.index ["availability_id"], name: "index_reservations_on_availability_id"
    t.index ["listing_id"], name: "index_reservations_on_listing_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "accuracy"
    t.string "communication"
    t.string "cleanliness"
    t.string "checkin"
    t.string "owners_behaviour"
    t.string "valueformoney"
    t.string "reviewerid"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reservation_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "specks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "listing_id"
    t.index ["listing_id"], name: "index_specks_on_listing_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
