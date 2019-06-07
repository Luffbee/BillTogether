require 'bundler/setup'
require_relative 'database/database'
require 'bcrypt'
require 'multi_json'


class User < Sequel::Model
  plugin :validation_helpers
  # id, email, name, password
  include BCrypt
  many_to_many :groups, join_table: :memberships
  one_to_many :paid_bills, class: :Bill, key: :payer_id
  one_to_many :bill_lines
  many_to_many :shared_bills, class: :Bill, join_table: :bill_lines

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def to_api
    {
      id: self.id,
      name: self.name,
      email: self.email,
    }
  end

  def validate
    super
    validates_presence [:name, :email, :password_hash]
    validates_format /\A[a-zA-Z]\w{1,127}\z/, :name
    validates_format URI::MailTo::EMAIL_REGEXP, :email
    validates_unique :email
  end
end


class Group < Sequel::Model
  plugin :validation_helpers
  # id, name, desc, create_time, joincode
  many_to_many :users, join_table: :memberships
  one_to_many :bills

  def before_save
    self.create_time ||= Time.now
    super
  end

  def before_validation
    self.create_time ||= Time.now
    super
  end

  def size
    self.users.length
  end

  def to_api
    {
      id: self.id,
      name: self.name,
      desc: self.desc,
      create_time: self.create_time,
      users: self.users.map { |u| u.to_api },
      joincode: self.joincode,
    }
  end

  def validate
    super
    validates_presence [:name, :desc, :create_time, :joincode]
    validates_format /\A\w{1,128}\z/, :name
    validates_format /\A\w{1,128}\z/, :joincode
  end
end


class Membership < Sequel::Model
  # user_id, group_id
  many_to_one :user
  many_to_one :group
end


class Bill < Sequel::Model
  # id, group_id, payer_id
  many_to_one :group
  many_to_one :payer, class: :User, key: :payer_id
  one_to_many :bill_lines
  many_to_many :users, join_table: :bill_lines
end

class BillLine < Sequel::Model
  # amount, user_id, bill_id
  many_to_one :bill
  many_to_one :user
end
