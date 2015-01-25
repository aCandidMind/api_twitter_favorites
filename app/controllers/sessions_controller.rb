class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(twitter_id: auth['uid']) || User.create_user(auth)
    TwitterFavoritesJob.perform_later( user )
    render nothing: true # Will need to Redirect user to Ember app, and tell Ember if it's a new user.
  end
end