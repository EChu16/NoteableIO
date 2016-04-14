class Subscription < ActiveRecord::Base
	attr_accessible :subscriber_id, :type, :user_id
	belongs_to :subscriber, :class_name => "User"
	belongs_to :user

	def notify_subscriber
  		if type == "email" || type == "both"
			Notifier.email_subscriber(subscriber, user, stream)
		end
		if type == "phone" || type == "both"
			#text user
		end
	end
end
