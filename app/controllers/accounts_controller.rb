class AccountsController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:spotify_token] = spotify_user.credentials.token
    flash[:notice] = "Logged into Spotify"
    redirect_to musics_path
  end
end
