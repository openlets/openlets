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

ActiveRecord::Schema.define(:version => 20140617142201) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "economy_id"
  end

  add_index "categories", ["economy_id"], :name => "index_categories_on_economy_id"

  create_table "category_connections", :force => true do |t|
    t.string   "categoriable_type"
    t.integer  "categoriable_id"
    t.integer  "category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "interest_type"
  end

  add_index "category_connections", ["categoriable_id"], :name => "index_category_connections_on_categoriable_id"
  add_index "category_connections", ["categoriable_type"], :name => "index_category_connections_on_categoriable_type"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conversations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "second_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "conversations", ["second_user_id"], :name => "index_conversations_on_second_user_id"
  add_index "conversations", ["user_id"], :name => "index_conversations_on_user_id"

  create_table "economies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "economy_type"
    t.string   "currency_name"
    t.string   "currency_type"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "domain"
    t.string   "name"
    t.integer  "max_debit",                     :default => -100
    t.boolean  "allow_anyone_to_create_items"
    t.boolean  "allow_anyone_to_create_wishes"
    t.boolean  "invite_only"
    t.string   "logo"
    t.string   "bg_image"
    t.integer  "user_id"
    t.integer  "max_credit"
    t.integer  "zero_point",                    :default => 0
    t.text     "faq"
    t.string   "title_color"
    t.string   "seo_title"
    t.string   "seo_description"
    t.string   "big_logo"
  end

  add_index "economies", ["user_id"], :name => "index_economies_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.string   "image"
    t.string   "workflow_state"
    t.integer  "member_id"
    t.datetime "state_changed_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "wish_id"
  end

  add_index "items", ["member_id"], :name => "index_items_on_member_id"
  add_index "items", ["member_id"], :name => "index_items_on_user_id"
  add_index "items", ["wish_id"], :name => "index_items_on_wish_id"

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "locationable_type"
    t.integer  "locationable_id"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "ip"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "locations", ["locationable_id"], :name => "index_locations_on_locationable_id"

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "economy_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "workflow_state"
    t.datetime "state_changed_at"
    t.integer  "manager_id"
  end

  add_index "members", ["economy_id"], :name => "index_members_on_economy_id"
  add_index "members", ["user_id"], :name => "index_members_on_user_id"

  create_table "members_roles", :id => false, :force => true do |t|
    t.integer "member_id"
    t.integer "role_id"
  end

  add_index "members_roles", ["member_id", "role_id"], :name => "index_members_roles_on_member_id_and_role_id"

  create_table "messages", :force => true do |t|
    t.string   "text"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "messages", ["conversation_id"], :name => "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "array"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "amount"
    t.integer  "sending_wallet_id"
    t.integer  "receiving_wallet_id"
    t.string   "workflow_state"
    t.datetime "state_changed_at"
    t.integer  "item_id"
    t.string   "transaction_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "economy_id"
  end

  add_index "transactions", ["economy_id"], :name => "index_transactions_on_economy_id"
  add_index "transactions", ["item_id"], :name => "index_transactions_on_item_id"
  add_index "transactions", ["receiving_wallet_id"], :name => "index_transactions_on_seller_id"
  add_index "transactions", ["sending_wallet_id"], :name => "index_transactions_on_buyer_id"

  create_table "users", :force => true do |t|
    t.string   "image"
    t.string   "location"
    t.string   "username"
    t.string   "workflow_state"
    t.text     "about"
    t.datetime "state_changed_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.string   "locale"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "national_id"
    t.string   "address"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "fax"
    t.date     "birth_date"
    t.string   "profession"
    t.string   "job"
    t.string   "relationship_status"
    t.string   "company_name"
    t.string   "company_site"
    t.string   "office_number"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "wallets", :force => true do |t|
    t.integer  "walletable_id"
    t.string   "walletable_type"
    t.integer  "economy_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "wallets", ["economy_id"], :name => "index_wallets_on_economy_id"
  add_index "wallets", ["walletable_id"], :name => "index_wallets_on_walletable_id"

  create_table "wishes", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "member_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "workflow_state"
    t.datetime "state_changed_at"
    t.text     "description"
  end

  add_index "wishes", ["member_id"], :name => "index_wishes_on_member_id"
  add_index "wishes", ["member_id"], :name => "index_wishes_on_user_id"

end
