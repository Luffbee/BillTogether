class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

    post '/register' do
      user = User.new(
        name: params['name'],
        email: params['email'],
      )
      user.password = params['password']
      if user.valid?
        user.save
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
end
