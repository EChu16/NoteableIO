Golf::Application.routes.draw do

	root :to => "home#index"
	match 'auth/:provider/callback', to: 'sessions#create'
	match 'auth/failure', to: redirect('/')
	match 'signout', to: 'sessions#destroy', as: 'signout'
	match 'videos/:url/save_note', to: 'videos#save_note', as: 'save_note_video'
	match 'notes/:id/delete', to: 'notes#delete'
	match 'notes/:id/update', to: 'notes#update'
	match 'videos/:url', to: 'videos#show', as: 'video'
	match 'videos', to: 'videos#show', as: 'new_video'
	match '/sign_up', to: 'home#sign_up', as: 'sign_up'
	match 'users/settings', to: 'users#settings', as: 'settings'
	match 'users/update', to: 'users#update', as: 'update_user'
	resources :streams
	match 'streams/:id', to: "streams#show", :via => "post"
	match 'streams/:id/stream', to: 'streams#stream', as: 'stream_stream'
	match 'streams/:id/save_note', to: 'streams#stream', as: 'save_note_stream'
	match 'streams/:id/end', to: 'streams#end', as: 'end_stream'
	match 'streams/:id/:user_id', to: 'streams#view_notes', as: 'view_stream_notes'
	match 'streams/:id/:user_id/copy_notes', to: 'streams#copy_notes', as: 'copy_stream_notes'
	match 'videos/:id/:user_id', to: 'videos#view_notes', as: 'view_video_notes'
	match 'videos/:id/:user_id/copy_notes', to: 'videos#copy_notes', as: 'copy_video_notes'
	resources :subscriptions
	match '/votes/vote/:note_collection_id', to: 'votes#vote', as: 'vote'
end
