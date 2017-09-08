require 'twilio-ruby'

class Twilionotifier

	attr_accessor :loosers, :finalwinner

	def initialize
		begin	
			@client = Twilio::REST::Client.new(
				ENV['TWILIO_ACCOUNT_SID'],
				ENV['TWILIO_AUTH_TOKEN']
			)
		rescue Twilio::REST::RequestError => e
   			puts e.message
		end			
	end

	def notify_through_text(send_to, message)

			begin	
				@client.account.messages.create(
				from: ENV['TWILIO_PHONE_NUMBER'],
				to: send_to.to_s,
				body: "#{message}"
				
				# return true
			)

			rescue Twilio::REST::RequestError => e
   				puts e.message
			end
	end
	

	# def notifyfinalwinner()
	# 	@client.messages.create(
	# 		from: ENV['TWILIO_PHONE_NUMBER'],
	# 		to: "+13157515747",
	# 		body: "Hello! Is there anybody in there!"
	# 	)		
	# end

end


