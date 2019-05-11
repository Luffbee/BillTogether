require 'bundler/setup'
require 'sinatra'
require 'sinatra/cookies'
require 'jwt'
require 'multi_json'

module Sinatra
  module Authentication
    class Token
      HMAC_SEC = SecureRandom.hex(32)
      def self.encode(payload)
        JWT.encode payload, HMAC_SEC, 'HS256'
      end

      def self.decode(token) 
        leeway = 10 # seconds
        begin
          JWT.decode token, HMAC_SEC, true, {exp_leeway: leeway, algorithm: 'HS256'}
        rescue JWT::ExpiredSignature
          [{}, {'error' => "Expired Token"}]
        rescue JWT::DecodeError
          [{}, {'error' => "Invalid Token"}]
        end
      end
    end

    def authenticate!
      token = cookies["JWT"]
      if token.nil?
        @current_user = nil
        @auth_error = 'No Token'
        return
      end
      payload = Token.decode(token)
      if payload[1].has_key? 'error'
        @current_user = nil
        @auth_error = payload[1]['error']
      else
        @current_user = payload[0]
      end
    end

    def issue_token(user, lifelength)
      exp = Time.now.to_i + lifelength
      payload = user.merge({'exp' => exp})
      token = Token.encode(payload)
      response.set_cookie(:JWT, :value => token,
                          :expires => Time.now + lifelength,
                          :path => '/',
                          :httponly => true)
    end

    def remove_token()
      response.set_cookie(:JWT, :value => '',
                          :expires => Time.now,
                          :path => '/',
                          :httponly => true)
    end

    def current_user
      @current_user
    end

    def auth_error
      @auth_error
    end

    def authenticated?
      !current_user.nil?
    end
  end

  helpers Authentication
end
