require 'data_mapper'
require 'dm-validations'
require 'dm-types'
require 'fileutils'

data_dir = "#{Dir.pwd}"
db_file = File.join(data_dir, 'billtogather.db')

FileUtils.mkdir_p data_dir
DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, "sqlite3://#{db_file}")

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :required => true, :unique => true,
    :format => :email_address,
    :message => {
      :presence   => "Email address is necessary.",
      :is_unique  => "Email address is already used.",
      :format     => "Invalid email address.",
    }
  property :username, String, :required => true
  property :password, BCryptHash, :required => true

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  has n, :memberships
  has n, :groups, :through => :memberships
  has n, :paid_bills, 'Bill', :child_key => [ :payer ]
  has n, :bill_lines
  has n, :shared_bills, 'Bill', :through => :bill_lines, :via => :bill

end

class Group
  include DataMapper::Resource

  property :id, Serial
  property :groupname, String, :required => true
  property :size, Integer, :required => true

  has n, :memberships
  has n, :users, :through => :memberships
  has n, :bills
end

class Membership
  include DataMapper::Resource

  property :balance, Float, :required => true, :default => 0.0
  
  belongs_to :user, :key => true
  belongs_to :group, :key => true
end

class Bill
  include DataMapper::Resource

  property :id, Serial
  property :amount, Float, :required => true
  property :num_members, Integer, :required => true

  belongs_to :group, :required => true
  belongs_to :payer, 'User', :required => true
  has n, :bill_lines
  has n, :users, :throught => :bill_lines

end

class BillLine
  include DataMapper::Resource

  property :amount, Float, :required => true

  belongs_to :user, :key => true
  belongs_to :bill, :key => true
end

DataMapper.finalize

DataMapper.auto_upgrade!
#DataMapper.auto_migrate!
