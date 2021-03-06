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

ActiveRecord::Schema.define(version: 20161208162158) do

  create_table "blogs", force: :cascade do |t|
    t.string   "title",       default: ""
    t.text     "description", default: ""
    t.string   "slug",        default: ""
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      default: ""
    t.text     "body",       default: ""
    t.string   "slug",       default: ""
    t.integer  "blog_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["blog_id"], name: "index_posts_on_blog_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "occupants"
    t.string   "name",            default: ""
    t.integer  "user_id"
    t.datetime "movein"
    t.string   "primary_contact", default: ""
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", default: ""
    t.string   "last_name",  default: ""
    t.string   "email",      default: ""
    t.string   "password",   default: ""
    t.datetime "birthday"
    t.string   "phone",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "username"
  end

end
