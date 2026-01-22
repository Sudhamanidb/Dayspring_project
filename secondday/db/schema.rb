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

ActiveRecord::Schema[8.1].define(version: 2026_01_16_052824) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "email" #use profanity : true
    t.string "name"  #use profanity : true
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description" # Regex validation to not allow special char
    t.boolean "is_active" # use inbuilt validation only if it is checked acceptance:true
    t.string "name" #try for alpha neumaric value
    t.decimal "price" # if custom validation is True
    t.integer "stock" # write the custom validation to add only if product is marked as is_active --> True
    t.datetime "updated_at", null: false
  end
end
