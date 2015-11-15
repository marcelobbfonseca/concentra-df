class User < ActiveRecord::Base
    def self.koala(auth)
        access_token = auth['token']
        facebook = Koala::Facebook::API.new(access_token)
        facebook.get_object("me?fields=name,picture")
    end
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    #validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
    #has_secure_password nao precisa por com o devise, ja é tratado sozinho. da erro
    validates :password, presence: true, length: { minimum: 5 }

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
                                                      BCrypt::Password.create(string, cost: cost)
    end
    def User.new_token #retorna uma token aleatoria
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    #retorna true se o token for compativo do digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
    
end
