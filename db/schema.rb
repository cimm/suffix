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

ActiveRecord::Schema.define(:version => 20100912094243) do

  create_table "comments", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.text     "content",    :null => false
    t.string   "author"
    t.string   "mail"
    t.string   "url"
    t.datetime "created_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "locations", :force => true do |t|
    t.string   "label",                         :null => false
    t.float    "latitude",                      :null => false
    t.float    "longitude",                     :null => false
    t.boolean  "current",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["current"], :name => "index_locations_on_current"

  create_table "pages", :force => true do |t|
    t.string   "title",                            :null => false
    t.string   "permalink",                        :null => false
    t.text     "content",                          :null => false
    t.boolean  "in_navigation", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                           :null => false
    t.string   "permalink",                       :null => false
    t.text     "content",                         :null => false
    t.string   "author"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "comments_open", :default => true
  end

  add_index "posts", ["location_id"], :name => "index_posts_on_location_id"
  add_index "posts", ["permalink"], :name => "index_posts_on_permalink"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at"
  end

  add_index "taggings", ["post_id"], :name => "index_taggings_on_post_id"
  add_index "taggings", ["tag_id", "post_id"], :name => "index_taggings_on_tag_id_and_post_id", :unique => true
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string "name", :null => false
  end

end
