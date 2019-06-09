class BilltogatherAPIv1 < Sinatra::Application
  namespace '/api/v1' do
    NOFORCEAUTH = [
      '/login',
      '/register',
    ].map {|r| '/api/v1' + r}

    helpers do
      def check(cond, statuscode, errormsg)
        if not cond
          halt statuscode, MultiJson.dump({
            error: {
              message: errormsg,
            }
          })
        end
      end
    end

    before do
      authenticate!
      if !authenticated?
        check(NOFORCEAUTH.include?(request.path_info), 401, auth_error)
      end
    end

    get '/' do
      'Billtogather API'
    end
  end
end

