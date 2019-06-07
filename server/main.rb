require 'bundler/setup'
require 'sinatra'
require 'sinatra/namespace'
require 'fileutils'
require 'multi_json'
require_relative 'model.rb'
require_relative 'auth.rb'


class BilltogatherAPIv1 < Sinatra::Application
  register Sinatra::Namespace
  set :public_folder, File.join(__dir__, '../client/dist')
  get '/' do
    send_file File.join(__dir__, '../client/dist/index.html')
  end

  run! if app_file == $0
end

require_relative 'api/init.rb'
