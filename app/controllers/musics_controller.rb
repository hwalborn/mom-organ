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
    resp = Music.authorize
    token = JSON.parse(resp)['access_token']
    uri = Music.get_uri(@music, token)
    if(uri)
      @spotify = "https://open.spotify.com/embed?uri=#{uri}&theme=white&view=coverart"
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
