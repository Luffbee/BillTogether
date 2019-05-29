require 'bundler/setup'
require 'sequel'
require 'logger'
require 'fileutils'

db_file = File.join(__dir__, 'billtogather.db')

DB = Sequel.connect("sqlite://#{db_file}", logger: Logger.new(STDOUT))
