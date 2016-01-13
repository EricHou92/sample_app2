# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151203195410) do

  create_table "administrators", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "realname"
    t.integer  "empno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "rating"
    t.string   "content"
    t.integer  "user_id"
    t.integer  "thing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "things", force: :cascade do |t|
    t.string   "title"
    t.integer  "depreciation_rate"
    t.float    "price"
    t.integer  "style"
    t.text     "description"
    t.string   "picture_path"
    t.string   "picture_type"
    t.boolean  "commission"
    t.boolean  "delivery"
    t.boolean  "erasure"
    t.integer  "user_id"
    t.integer  "administrator_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "mail"
    t.string   "telephone"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["mail"], name: "index_users_on_mail", unique: true

end
