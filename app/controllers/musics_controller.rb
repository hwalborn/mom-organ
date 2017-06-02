class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :destroy, :update, :edit]
  before_action :create_new

  def index
    @musics = Music.display(params[:music])
    respond_to do |format|
      format.html
      format.csv { send_data Music.all.to_csv }
    end
  end

  def create
    music = Music.downcase_n_save(music_params)
    redirect_to music
  end

  def show
    byebug
    if spotify_logged_in?
      # redirect_to "https://accounts.spotify.com/authorize/?client_id=427aca466f7b4a67bf78a85d5af51b3a&response_type=code&redirect_uri=http%3A%2F%2Flocalhost:3000%2Fcallback"
      # Music.authorize
      RestClient.get "https://accounts.spotify.com/authorize/?client_id=#{Rails.application.secrets.client_id}&response_type=code&redirect_uri=https%3A%2F%2Forgan-izer.herokuapp.com%2"
      # RestClient::Request.execute(method: :get, url: "https://accounts.spotify.com/authorize/?client_id=#{Rails.application.secrets.client_id}&response_type=code&redirect_uri=https%3A%2F%2Forgan-izer.herokuapp.com%2")
      uri = RSpotify::Track.search(@music.title)[0]
      if(uri)
        uri = uri.uri
        @spotify = "https://open.spotify.com/embed?uri=#{uri}&theme=white&view=coverart"
      end
    end
  end

  def update
    @music.update(music_params)
    redirect_to @music
  end

  def destroy
    Music.delete(@music)
    redirect_to musics_path
  end

  def spotify
    resp = Music.post_authorize(params['code'])
    session[:access_token] = JSON.parse(resp)['access_token']
    byebug
  end

  private
  def music_params
    params.require(:music).permit(:title, :hymn_tune_title, :book, :page_number, :composer, :holiday, :search_by, :query)
  end

  def set_music
    @music = Music.find(params[:id])
  end

  def create_new
    @music_new = Music.new
  end
end
