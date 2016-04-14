class User < ActiveRecord::Base
	attr_accessible :email, :name
	has_many :note_collections
	has_many :streams
	has_many :accounts
	has_many :notes, :through => :note_collections
	has_many :subscriptions
	has_many :subscribers, :through => :subscriptions
	has_many :subscriptions_made, :class_name => "Subscription", :foreign_key => :subscriber_id

	def self.from_omniauth(auth, current_user)
		user = where(:email=>auth.info.email).first_or_initialize

		if current_user
			user = current_user
		end

		user.name = auth.info.name unless user.name
		user.email = auth.info.email
		user.accounts.where(auth.slice(:provider)).first_or_initialize.tap do |account|
			account.provider = auth.provider
			account.uid = auth.uid
			account.oauth_token = auth.credentials.token
			account.oauth_expires_at = Time.at(auth.credentials.expires_at || Time.now + 60.days)
			account.user = user
			account.save!
		end
		user.save!
		return user
	end

	def note_collection_for(noteable)
		collection = note_collections.where(:noteable_type => noteable.class.name, :noteable_id => noteable.id).first
		unless collection
			if noteable.is_a?(Video) && noteable.stream
				collection = note_collections.where(:noteable_type => "Stream", :noteable_id => noteable.stream.id).first
			elsif noteable.is_a?(Stream) && noteable.video
				collection = note_collections.where(:noteable_type => "Video", :noteable_id => noteable.video_id).first
			end
		end
		return collection
	end
	
	def last_video
		last_video_id ? Video.where(:id => last_video_id).first : nil
	end

	def facebook
		return @facebook ||= self.accounts.select{|a| a.provider == "facebook"}.first
	end

	def twitter
		return @twitter ||= self.accounts.select{|a| a.provider == "twitter"}.first
	end

	def github
		return @github ||= self.accounts.select{|a| a.provider == "github"}.first
	end

	

end
