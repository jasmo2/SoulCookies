module  Api
  class BaseController < ApplicationController
    attr_accessor :current_customer
    skip_before_filter  :verify_authenticity_token
    protect_from_forgery with: :null_session

    def current_customer
      @current_customer
    end

    protected

    def access_private
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_customer = CustomersUser.find_by_oauth_token(token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {"error": "credenciales invalidas"}, status: :unauthorized
    end
  end
end