class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook

		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted? || @user.save
			sign_in_and_redirect @user, :event => :authentication
			# raise request.env["omniauth.auth"].to_yaml
			set_flash_message(:notice, :success, :kind => "facebook") if
			is_navigational_format?
		else
			# raise request.env["omniauth.auth"].to_yaml
			# session["devise.user_attributes"] = user.attributes
			p "hello"
			p @user.errors
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
			flash[:notice] = "Your Facebook profile is not verified. We can't use it to sign you up. Please fill up the forms below"
		end
	end


	def failure
		redirect_to root_path
	end

end

