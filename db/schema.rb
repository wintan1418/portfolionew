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

ActiveRecord::Schema[8.0].define(version: 2026_04_10_195953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "color", default: "#6366f1"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "author_name", null: false
    t.string "author_email"
    t.text "body", null: false
    t.bigint "post_id", null: false
    t.bigint "parent_id"
    t.boolean "approved", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["post_id", "approved"], name: "index_comments_on_post_id_and_approved"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "subject"
    t.text "message", null: false
    t.string "status", default: "unread"
    t.string "phone"
    t.string "company"
    t.string "budget_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string "institution", null: false
    t.string "degree"
    t.string "field_of_study"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company", null: false
    t.string "role", null: false
    t.text "description"
    t.string "location"
    t.string "company_url"
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "current", default: false
    t.string "employment_type"
    t.text "highlights", default: [], array: true
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "subject", null: false
    t.text "body", null: false
    t.string "status", default: "draft"
    t.datetime "sent_at"
    t.integer "recipients_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_views", force: :cascade do |t|
    t.string "path", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "referrer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_page_views_on_created_at"
    t.index ["path"], name: "index_page_views_on_path"
  end

  create_table "post_likes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "session_id"], name: "index_post_likes_on_post_id_and_session_id", unique: true
    t.index ["post_id"], name: "index_post_likes_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "excerpt"
    t.string "status", default: "draft"
    t.datetime "published_at"
    t.boolean "featured", default: false
    t.integer "reading_time"
    t.string "meta_title"
    t.text "meta_description"
    t.string "og_title"
    t.text "og_description"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content_markdown"
    t.integer "comments_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["status", "published_at"], name: "index_posts_on_status_and_published_at"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "headline"
    t.text "bio"
    t.text "about"
    t.string "email"
    t.string "phone"
    t.string "location"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "twitter_url"
    t.string "website_url"
    t.boolean "available_for_hire", default: true
    t.string "availability_text"
    t.text "meta_description"
    t.string "og_title"
    t.text "og_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "summary"
    t.string "live_url"
    t.string "github_url"
    t.text "tech_stack", default: [], array: true
    t.boolean "featured", default: false
    t.integer "position", default: 0
    t.date "completed_on"
    t.string "status", default: "completed"
    t.string "project_type", default: "personal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "challenge"
    t.text "solution"
    t.text "results"
    t.string "client_name"
    t.string "client_role"
    t.text "metrics"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.integer "proficiency", default: 80
    t.string "icon"
    t.integer "position", default: 0
    t.boolean "featured", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_links", force: :cascade do |t|
    t.string "platform", null: false
    t.string "url", null: false
    t.string "icon"
    t.integer "position", default: 0
    t.boolean "visible", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "status", default: "active"
    t.string "token", null: false
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
    t.index ["token"], name: "index_subscribers_on_token", unique: true
  end

  create_table "testimonials", force: :cascade do |t|
    t.string "author_name", null: false
    t.string "author_title"
    t.string "company"
    t.text "content", null: false
    t.integer "rating"
    t.boolean "featured", default: false
    t.integer "position", default: 0
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "status", default: "approved"
    t.datetime "submitted_at"
    t.index ["token"], name: "index_testimonials_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "posts", "categories"
  add_foreign_key "sessions", "users"
end
