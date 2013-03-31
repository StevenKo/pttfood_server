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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130330042308) do

  create_table "articles", :force => true do |t|
    t.string   "author"
    t.string   "title",            :default => ""
    t.string   "release_time"
    t.text     "content"
    t.string   "link"
    t.string   "ptt_web_link"
    t.integer  "category_id"
    t.boolean  "is_from_category", :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "articles", ["category_id"], :name => "index_articles_on_category_id"
  add_index "articles", ["ptt_web_link"], :name => "index_articles_on_ptt_web_link"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "link"
    t.boolean  "is_area"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["is_area"], :name => "index_categories_on_is_area"
  add_index "categories", ["link"], :name => "index_categories_on_link"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

end
