class BilltogatherAPIv1 < Sinatra::Application
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
  end
end

