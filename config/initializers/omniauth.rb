ENV['FACEBOOK_APP_ID'] = '1446047778965913'
ENV['FACEBOOK_SECRET'] = '5cf67604da479d38e71001aaf2abe612'
ENV['GITHUB_APP_ID'] = 'd07b33888e1872d87cba'
ENV['GITHUB_SECRET'] = 'b9c121caefc69e3404f20fb06a7b32b7bd461052'
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
	provider :github, ENV['GITHUB_APP_ID'], ENV['GITHUB_SECRET'], scope: "user,repo,gist,email"
end
