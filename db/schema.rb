# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100804025957) do

  create_table "employees", :force => true do |t|
    t.string   "fname",      :limit => 30, :null => false
    t.string   "lname",      :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["id", "fname", "lname", "created_at", "updated_at"], :name => "employees_index"

  create_table "stores", :force => true do |t|
    t.string   "name",       :limit => 30, :null => false
    t.string   "city",       :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores", ["id", "name", "city", "created_at", "updated_at"], :name => "stores_index"

end
