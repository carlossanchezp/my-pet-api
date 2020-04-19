class User < ApplicationRecord
    ### VALIDATIONS
    validates :email, presence: true
    validates :auth_token, uniqueness: true
    
    ### CALLBACKS
    before_create :generate_auth_token

    private 

    def generate_auth_token
        token = ''

        loop do
            token = SecureRandom.hex
            break token unless User.where(auth_token: token).first
        end

        self.auth_token = token
    end
end
