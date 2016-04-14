class Stream < ActiveRecord::Base
	attr_accessible :name, :user_id, :video_id, :session, :password
	belongs_to :user
	belongs_to :video
	has_many :note_collections, :as => :noteable


	def self.public
		where(:password => nil)
	end

	def self.private
		where("streams.password IS NOT NULL")
	end

	def set_password(plain_password)
		self.salt = SecureRandom.base64(8)
		self.assign_attributes(:password => Digest::SHA2.hexdigest(self.salt + plain_password))
	end

	def password_correct?(plain_password)
		return password == Digest::SHA2.hexdigest(salt + plain_password)
	end

	def internal_url
		return "/streams/#{id}"
	end
end
