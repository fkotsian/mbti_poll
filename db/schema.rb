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

ActiveRecord::Schema.define(version: 20140616062750) do

  create_table "tweet_pollers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string "t_id_str"
    t.string "created_at"
    t.string "text"
    t.string "retweet_count"
    t.string "retweeted"
    t.string "user_id_str"
    t.string "user_name"
    t.string "user_location"
    t.string "user_statuses_count"
    t.string "user_followers_count"
    t.string "user_friends_count"
    t.string "stored_at"
  end

end
