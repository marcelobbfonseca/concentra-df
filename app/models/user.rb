class User < ActiveRecord::Base
    has_one :vacancy #, complement
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook]
    #attr_accessible :admin #ignora isso por enquanto. tornar acessivel novo campo
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
         
        #user.name = auth.info.name   # assuming the user model has a name
        #user.image = auth.info.image # assuming the user model has an image
      end
    end
    #copia o email do usuario se existir
    def self.new_with_session(params, session) 
        super.tap do |user|
          if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
          end
        end
    end

    def admin #precisa definir isso!!!! nao sei se esta certo
      !self.admin.blank?
    end
    def admin?
      self.admin
    end


end
