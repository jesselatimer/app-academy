class TracksController < ApplicationController
  before_action :require_logged_in
  
  def index
    @tracks = Track.all
    render :index
  end

  def new
    @track = Track.new
    @albums = Album.all
    render :new
  end

  def create
    @albums = Album.all
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @albums = Album.all
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @albums = Album.all
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy!
    redirect_to albums_url
  end

  private
  def track_params
    params.require(:track).permit(:title, :bonus, :lyrics, :album_id)
  end
end
