class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

    post '/login' do
      err = 'Invalid email or password.'
      user = User.where(email: params['email'])
      check(user.count == 1, 401, err)
      user = user.first
      check(user.password == params['password'], 401, err)
      issue_token({'id'=>user.id}, 5 * 60 * 60)
      MultiJson.dump({user: user.to_api})
    end

    post '/logout' do
      remove_token
      "Logout success."
    end
  end
end

