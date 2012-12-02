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

ActiveRecord::Schema.define(:version => 20121109194651) do

  create_table "animal_medicines", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "medicine_id"
    t.integer  "recommended_num_of_units"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "medicine_costs", :force => true do |t|
    t.integer  "medicine_id"
    t.integer  "cost_per_unit"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "medicines", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock_amount"
    t.string   "method"
    t.string   "unit"
    t.boolean  "vaccine",      :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "notable_type"
    t.integer  "notable_id"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "owners", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "state",      :default => "PA"
  end

  create_table "pets", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "owner_id"
    t.string   "name"
    t.boolean  "female"
    t.date     "date_of_birth"
    t.boolean  "active",        :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "procedure_costs", :force => true do |t|
    t.integer  "procedure_id"
    t.integer  "cost"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "procedures", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "length_of_time"
    t.boolean  "active",         :default => true
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "treatments", :force => true do |t|
    t.integer  "visit_id"
    t.integer  "procedure_id"
    t.boolean  "successful"
    t.decimal  "discount",     :precision => 4, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "role"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "visit_medicines", :force => true do |t|
    t.integer  "visit_id"
    t.integer  "medicine_id"
    t.integer  "units_given"
    t.decimal  "discount",    :precision => 4, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "visits", :force => true do |t|
    t.integer  "pet_id"
    t.date     "date"
    t.integer  "weight"
    t.text     "notes"
    t.boolean  "overnight_stay"
    t.integer  "total_charge"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
