class Notifier < ActionMailer::Base
	default from: "donotreply@noteableio.com"

	def email_subscriber(subscriber, streamer, stream)
		@user = subscriber
		@streamer = streamer
		@stream = stream
		mail( :to => @user.email, :subject => streamer.name + ' has started streaming.' )
	end
end
