class ApplicationController < ActionController::API
    before_action :authenticate_api, :authenticate_and_sign_in

    include ApiPaginate
  
    def authenticate_api
      render status: :unprocessable_entity unless request.headers["HTTP_API_TOKEN"] == Rails.configuration.settings['api_token']
    end
  
    def authenticate_and_sign_in
      @current_user = User.where(auth_token: request.headers["HTTP_USER_AUTH_TOKEN"]).first unless request.headers["HTTP_USER_AUTH_TOKEN"].blank?
      render json: {message: {auth_token: 'invalid access'}}, status: :unauthorized if (@current_user.blank?)
    end
end
