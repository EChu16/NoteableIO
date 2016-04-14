class Account < ActiveRecord::Base
	attr_accessible :oauth_expires_at, :oauth_token, :provider, :uid
	belongs_to :user
end
