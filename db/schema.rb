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

ActiveRecord::Schema.define(version: 2018_12_04_212933) do

  create_table "artifacts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "model"
    t.string "description"
    t.index ["model"], name: "index_artifacts_on_model", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "phone"
    t.string "email"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "artifact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "cost", precision: 10, scale: 2, default: "0.0"
    t.index ["artifact_id"], name: "index_pieces_on_artifact_id"
  end

  create_table "repairs", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "artifact_id"
    t.integer "estimated_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "state", default: "PENDIENTE"
    t.decimal "cost", precision: 10, scale: 2, default: "0.0"
    t.index ["artifact_id"], name: "index_repairs_on_artifact_id"
    t.index ["code"], name: "index_repairs_on_code", unique: true
    t.index ["customer_id"], name: "index_repairs_on_customer_id"
  end

  create_table "revisions", force: :cascade do |t|
    t.text "notes"
    t.integer "repair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repair_id"], name: "index_revisions_on_repair_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "cost", precision: 10, scale: 2
    t.integer "artifact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artifact_id"], name: "index_tasks_on_artifact_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
