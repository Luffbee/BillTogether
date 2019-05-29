require 'bundler/setup'
require 'sinatra'
require 'sinatra/namespace'
require 'fileutils'
require 'multi_json'
require_relative 'model'
require_relative 'auth'


class BilltogatherAPIv1 < Sinatra::Application
  register Sinatra::Namespace
  set :public_folder, File.join(__dir__, '../client/dist')
  get '/' do
    send_file File.join(__dir__, '../client/dist/index.html')
  end

  namespace '/api/v1' do
    NOFORCEAUTH = [
      '/login',
      '/register',
    ].map {|r| '/api/v1' + r}

    before do
      authenticate!
      if !authenticated?
        pass if NOFORCEAUTH.include? request.path_info
        halt 401, MultiJson.dump({
          error: {
            type: 'Authentication',
            message: auth_error,
          }
        })
      end
    end

    get '/' do
      'Billtogather API'
    end

    post '/register' do
      user = User.new(
        name: params['name'],
        email: params['email'],
      )
      user.password = params['password']
      if user.valid?
        user.save
        status 200
        issue_token({'id'=>user.id}, 5 * 60 * 60)
        MultiJson.dump({
          user: user.to_api
        })
      else
        status 400
        MultiJson.dump({
          error: {
            type: 'Register',
            message: user.errors,
          }
        })
      end
    end

    post '/login' do
      err = MultiJson.dump({
        error: {
          type: 'Login',
          message: 'Invalid email or password.',
        }
      })
      user = User.where(email: params['email'])
      if user.count != 1
        halt 401, err
      end
      user = user.first
      if user.password == params['password']
        issue_token({'id'=>user.id}, 5 * 60 * 60)
        MultiJson.dump({user: user.to_api})
      else
        halt 401, err
      end
    end

    post '/logout' do
      remove_token
      "Logout success."
    end

    get '/user' do
      id = current_user['id']
      user = User[id]
      MultiJson.dump({user: user.to_api})
    end

    get '/user/:id' do
      id = params['id']
      user = User[id]
      if user
        MultiJson.dump({user: user.to_api})
      else
        halt 404, MultiJson.dump({
          error: {
            type: 'User',
            message: 'Invalid user id.',
          }
        })
      end
    end
  end

  run! if app_file == $0
end

