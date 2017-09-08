class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # mount_uploader :image, ImageUploader

  has_many :listings,  dependent: :destroy 

  has_many :payments,  dependent: :destroy 


	def self.new_with_session(params, session)         
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      			user.email = data["email"] if user.email.blank?
    	end
		end
	end



	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        p auth.info      
    		user.email = auth.info.email
    		user.encrypted_password = Devise.friendly_token[0,20]

        if auth.info.email != nil
          user.name = auth.info.email.split("@")[0]  # assuming the user model has a name
        else
          user.name = "user#{auth.uid}"
        end   		
    		user.image = auth.info.image # assuming the user model has an image
  		end
	end

  def password_required?
    super && provider.blank?
  end

  # def email_required?
  #   false
  # end 

end
