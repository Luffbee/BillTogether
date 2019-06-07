class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

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
  end
end

