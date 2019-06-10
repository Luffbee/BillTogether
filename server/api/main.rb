class BilltogatherAPIv1 < Sinatra::Application
  set(:method) do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end

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

      def data
        @data
      end
    end

    before do
      authenticate!
      if !authenticated?
        check(NOFORCEAUTH.include?(request.path_info), 401, auth_error)
      end
    end


    before :method => :post do
      begin
        @data = MultiJson.load(request.body.read)
      rescue MultiJson::ParseError => e
        check(false, 400, 'Invalid json body.')
      end
    end


    get '/' do
      'Billtogather API'
    end
  end
end

