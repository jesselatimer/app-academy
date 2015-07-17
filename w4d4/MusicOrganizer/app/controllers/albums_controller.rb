class AlbumsController < ApplicationController
  before_action :require_logged_in, except: :index

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    @bands = Band.all
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @bands = Band.all
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy!
    redirect_to bands_url
  end

  private
  def album_params
    params.require(:album).permit(:title, :studio, :band_id)
  end
end
