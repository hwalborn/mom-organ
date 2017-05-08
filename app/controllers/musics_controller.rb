class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :destroy, :update, :edit]

  def index
    @music = Music.new
    @musics = Music.display(params[:music])
    respond_to do |format|
      format.html
      format.csv { send_data Music.all.to_csv }
    end
  end

  def new
    if logged_in?
      @music = Music.new
    else
      flash[:error] = "You must be logged in to create music"
      redirect_to musics_path
    end
  end

  def create
    music = Music.create(music_params)
    redirect_to music
  end

  def show
  end

  def edit
    if !logged_in?
      flash[:error] = "You must be logged in to edit music"
      redirect_to musics_path
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
    params.require(:music).permit(:title, :hymn_tune_title, :book, :page_number, :composer, :holiday)
  end

  def set_music
    @music = Music.find(params[:id])
  end
end
