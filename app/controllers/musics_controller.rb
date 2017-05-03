class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :destroy, :update]

  def index
    @musics = Music.all.sort_by{|music| music.title}
  end

  def new
    @music = Music.new
  end

  def create
    music = Music.create(music_params)
    redirect_to music
  end

  def show
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
