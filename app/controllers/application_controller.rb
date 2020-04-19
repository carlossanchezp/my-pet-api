class ApplicationController < ActionController::API
    before_action :authenticate_api, :authenticate_and_sign_in

    include ApiResponse
  
    def authenticate_api
      api_render({}, :unauthorized) unless request.headers["HTTP_API_TOKEN"] == Rails.configuration.settings['api_token']
    end
  
    def authenticate_and_sign_in
      @current_user = User.where(auth_token: request.headers["HTTP_USER_AUTH_TOKEN"]).first unless request.headers["HTTP_USER_AUTH_TOKEN"].blank?
      api_render({errors: {auth_token: 'invalid access'} }, :unauthorized) if (@current_user.blank?)
    end
end
