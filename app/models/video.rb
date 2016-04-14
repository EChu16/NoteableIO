class Video < ActiveRecord::Base
	attr_accessible :url
	has_many :note_collections, :as => :noteable
	has_one :stream

	def name
		return "http://youtube.com/watch?v=#{url}"
	end

	def find_by_url(url)
		return where(:url=>url).first
	end

	def internal_url
		return "/videos/#{url}"
	end
end
