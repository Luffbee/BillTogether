require 'sinatra'
require 'data_mapper'

DataMapper.setup :default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db"
