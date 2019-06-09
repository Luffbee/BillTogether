require_relative 'database'

DB.create_table(:users) do
  primary_key :id
  String :email, null: false, unique: true
  String :name, null: false
  check{length(name) >= 2}
  String :password_hash, null: false,
    fixed: true, size: 60 # BCrypt::Password
  index :email
end

DB.create_table(:groups) do
  primary_key :id
  String :name, null: false
  check{length(name) >= 2}
  String :joincode, null: false
  String :desc, null: false, default: ''
  Time :create_time, null: false
end

DB.create_table(:memberships) do
  foreign_key :user_id, :users, null: false
  foreign_key :group_id, :groups, null: false
  primary_key [:user_id, :group_id]
  index [:user_id, :group_id]
end

DB.create_table(:bills) do
  primary_key :id
  foreign_key :group_id, :groups, null: false
  foreign_key :payer_id, :users, null: false
  String :desc, null: false, default: ''
  Time :create_time, null: false
end

DB.create_table(:bill_lines) do
  Float :amount, null: false
  foreign_key :user_id, :users, null: false
  foreign_key :bill_id, :bills, null: false
  primary_key [:user_id, :bill_id]
  index [:user_id, :bill_id]
end
