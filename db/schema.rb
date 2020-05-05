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

ActiveRecord::Schema.define(version: 20200505172934) do

  create_table "agents", force: :cascade do |t|
    t.string "name"
  end

  create_table "buyers", force: :cascade do |t|
    t.float   "budget"
    t.string  "name"
    t.integer "agent_id"
  end

  create_table "house_visits", force: :cascade do |t|
    t.integer "house_id"
    t.integer "buyer_id"
  end

  create_table "houses", force: :cascade do |t|
    t.float   "price"
    t.integer "agent_id"
  end

end
