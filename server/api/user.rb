class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do

    post '/register' do
      user = User.new(
        name: data['name'],
        email: data['email'],
      )
      user.password = data['password']
      check(user.valid?, 400, user.errors)
      user.save
      issue_token({'id'=>user.id}, 5 * 60 * 60)
      MultiJson.dump({
        user: user.to_api
      })
    end

    get '/user' do
      id = current_user['id']
      user = User[id]
      MultiJson.dump({user: user.to_api})
    end

    #get '/user/:id' do
    #  id = params['id']
    #  user = User[id]
    #  check(!user.nil?, 404, 'Invalid user id.')
    #  MultiJson.dump({user: user.to_api})
    #end
  end
end
