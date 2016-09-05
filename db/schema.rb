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

ActiveRecord::Schema.define(version: 20160902071041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "uuid"
    t.boolean  "default",     default: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_apps_on_user_id", using: :btree
    t.index ["uuid"], name: "index_apps_on_uuid", unique: true, using: :btree
  end

  create_table "barcodes", force: :cascade do |t|
    t.string   "format"
    t.string   "content"
    t.string   "image"
    t.string   "barcodeable_type"
    t.integer  "barcodeable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["barcodeable_type", "barcodeable_id"], name: "index_barcodes_on_barcodeable_type_and_barcodeable_id", using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.boolean  "official",    default: false
    t.string   "logo"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "commodities", force: :cascade do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "measured_in"
    t.boolean  "generic",           default: false
    t.boolean  "moderated",         default: false
    t.string   "uuid"
    t.integer  "brand_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["brand_id"], name: "index_commodities_on_brand_id", using: :btree
  end

  create_table "commodity_references", force: :cascade do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "measured_in"
    t.boolean  "generic",              default: false
    t.boolean  "moderated",            default: false
    t.string   "uuid"
    t.integer  "brand_id"
    t.integer  "app_id"
    t.integer  "commodity_id"
    t.integer  "hscode_section_id"
    t.integer  "hscode_chapter_id"
    t.integer  "hscode_heading_id"
    t.integer  "hscode_subheading_id"
    t.integer  "unspsc_segment_id"
    t.integer  "unspsc_family_id"
    t.integer  "unspsc_class_id"
    t.integer  "unspsc_commodity_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["app_id"], name: "index_commodity_references_on_app_id", using: :btree
    t.index ["brand_id"], name: "index_commodity_references_on_brand_id", using: :btree
    t.index ["commodity_id"], name: "index_commodity_references_on_commodity_id", using: :btree
    t.index ["hscode_chapter_id"], name: "index_commodity_references_on_hscode_chapter_id", using: :btree
    t.index ["hscode_heading_id"], name: "index_commodity_references_on_hscode_heading_id", using: :btree
    t.index ["hscode_section_id"], name: "index_commodity_references_on_hscode_section_id", using: :btree
    t.index ["hscode_subheading_id"], name: "index_commodity_references_on_hscode_subheading_id", using: :btree
    t.index ["unspsc_class_id"], name: "index_commodity_references_on_unspsc_class_id", using: :btree
    t.index ["unspsc_commodity_id"], name: "index_commodity_references_on_unspsc_commodity_id", using: :btree
    t.index ["unspsc_family_id"], name: "index_commodity_references_on_unspsc_family_id", using: :btree
    t.index ["unspsc_segment_id"], name: "index_commodity_references_on_unspsc_segment_id", using: :btree
  end

  create_table "custom_units", force: :cascade do |t|
    t.string   "property"
    t.string   "uom"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_custom_units_on_app_id", using: :btree
  end

  create_table "hscode_chapters", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.integer  "hscode_section_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["category"], name: "index_hscode_chapters_on_category", unique: true, using: :btree
    t.index ["hscode_section_id"], name: "index_hscode_chapters_on_hscode_section_id", using: :btree
  end

  create_table "hscode_headings", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.integer  "hscode_chapter_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["category"], name: "index_hscode_headings_on_category", unique: true, using: :btree
    t.index ["hscode_chapter_id"], name: "index_hscode_headings_on_hscode_chapter_id", using: :btree
  end

  create_table "hscode_sections", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.text     "range",       default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["category"], name: "index_hscode_sections_on_category", unique: true, using: :btree
  end

  create_table "hscode_subheadings", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.integer  "hscode_heading_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["category"], name: "index_hscode_subheadings_on_category", unique: true, using: :btree
    t.index ["hscode_heading_id"], name: "index_hscode_subheadings_on_hscode_heading_id", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.boolean  "accepted",        default: false
    t.integer  "app_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["app_id"], name: "index_invitations_on_app_id", using: :btree
    t.index ["token"], name: "index_invitations_on_token", unique: true, using: :btree
  end

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.text     "description"
    t.integer  "app_id"
    t.integer  "commodity_reference_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["app_id"], name: "index_links_on_app_id", using: :btree
    t.index ["commodity_reference_id"], name: "index_links_on_commodity_reference_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_members_on_app_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "member_type"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["member_type", "member_id"], name: "index_memberships_on_member_type_and_member_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "ownerships", force: :cascade do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "child_type"
    t.integer  "child_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["child_type", "child_id"], name: "index_ownerships_on_child_type_and_child_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_ownerships_on_parent_type_and_parent_id", using: :btree
  end

  create_table "packagings", force: :cascade do |t|
    t.string   "uom"
    t.float    "quantity"
    t.string   "name"
    t.string   "description"
    t.string   "uuid"
    t.integer  "commodity_reference_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["commodity_reference_id"], name: "index_packagings_on_commodity_reference_id", using: :btree
  end

  create_table "references", force: :cascade do |t|
    t.string   "kind"
    t.integer  "source_commodity_reference_id"
    t.integer  "target_commodity_reference_id"
    t.text     "description"
    t.integer  "app_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["app_id"], name: "index_references_on_app_id", using: :btree
  end

  create_table "specifications", force: :cascade do |t|
    t.string   "property"
    t.decimal  "value"
    t.decimal  "min"
    t.decimal  "max"
    t.string   "uom"
    t.integer  "parent_id",   null: false
    t.string   "parent_type", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "standardizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "standard_id"
    t.string   "referable_type"
    t.integer  "referable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["referable_type", "referable_id"], name: "index_standardizations_on_referable_type_and_referable_id", using: :btree
    t.index ["standard_id"], name: "index_standardizations_on_standard_id", using: :btree
    t.index ["user_id"], name: "index_standardizations_on_user_id", using: :btree
  end

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "logo"
    t.boolean  "official",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "status"
    t.text     "info"
    t.string   "url"
    t.integer  "commodity_reference_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["commodity_reference_id"], name: "index_states_on_commodity_reference_id", using: :btree
  end

  create_table "unspsc_classes", force: :cascade do |t|
    t.string   "code"
    t.string   "long_code"
    t.string   "description"
    t.integer  "unspsc_family_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["unspsc_family_id"], name: "index_unspsc_classes_on_unspsc_family_id", using: :btree
  end

  create_table "unspsc_commodities", force: :cascade do |t|
    t.string   "code"
    t.string   "long_code"
    t.string   "description"
    t.integer  "unspsc_class_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["unspsc_class_id"], name: "index_unspsc_commodities_on_unspsc_class_id", using: :btree
  end

  create_table "unspsc_families", force: :cascade do |t|
    t.string   "code"
    t.string   "long_code"
    t.string   "description"
    t.integer  "unspsc_segment_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["unspsc_segment_id"], name: "index_unspsc_families_on_unspsc_segment_id", using: :btree
  end

  create_table "unspsc_segments", force: :cascade do |t|
    t.string   "code"
    t.string   "long_code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",       null: false
    t.string   "provider",    null: false
    t.string   "uid",         null: false
    t.string   "oauth_token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["oauth_token"], name: "index_users_on_oauth_token", unique: true, using: :btree
  end

  add_foreign_key "apps", "users"
  add_foreign_key "commodities", "brands"
  add_foreign_key "commodity_references", "apps"
  add_foreign_key "commodity_references", "brands"
  add_foreign_key "commodity_references", "commodities"
  add_foreign_key "commodity_references", "hscode_chapters"
  add_foreign_key "commodity_references", "hscode_headings"
  add_foreign_key "commodity_references", "hscode_sections"
  add_foreign_key "commodity_references", "hscode_subheadings"
  add_foreign_key "commodity_references", "unspsc_classes"
  add_foreign_key "commodity_references", "unspsc_commodities"
  add_foreign_key "commodity_references", "unspsc_families"
  add_foreign_key "commodity_references", "unspsc_segments"
  add_foreign_key "custom_units", "apps"
  add_foreign_key "hscode_chapters", "hscode_sections"
  add_foreign_key "hscode_headings", "hscode_chapters"
  add_foreign_key "hscode_subheadings", "hscode_headings"
  add_foreign_key "invitations", "apps"
  add_foreign_key "links", "apps"
  add_foreign_key "links", "commodity_references"
  add_foreign_key "members", "apps"
  add_foreign_key "members", "users"
  add_foreign_key "memberships", "users"
  add_foreign_key "packagings", "commodity_references"
  add_foreign_key "references", "apps"
  add_foreign_key "standardizations", "standards"
  add_foreign_key "standardizations", "users"
  add_foreign_key "states", "commodity_references"
  add_foreign_key "unspsc_classes", "unspsc_families"
  add_foreign_key "unspsc_commodities", "unspsc_classes"
  add_foreign_key "unspsc_families", "unspsc_segments"
end
