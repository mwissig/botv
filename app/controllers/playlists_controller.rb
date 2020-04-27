class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
            @fullscreen = true
    @is_playlist = true
    @ids = []
    @videos = @playlist.items.order(:sort).all.paginate(:page => params[:page], :per_page => 1)


    @bulb = Bulb.new
    @comment = Comment.new
            @playlist.increment!(:plays)
            @playlist.updated_at = DateTime.now
            @playlist.save!
@thisvid = Video.find_by_id((@videos.first).video_id)
@thisvid.increment!(:plays)
@thisvid.updated_at = DateTime.now
@thisvid.save!

@items = Item.where(video_id: @thisvid.id)
@playlist_ids = []
@items.each do |item|
  @playlist_ids << item.playlist
end
@playlist_ids.uniq!
@playlists = Playlist.where(id: @playlist_ids.map(&:id))

  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
    @items = @playlist.items.order(:sort).all
  end

  def createplaylist
    @video = Video.find_by_id(params[:video_id])
    @playlist = Playlist.new(
      user_id: current_user.id,
      title: params[:title],
      description: params[:description],
      category1: params[:category1],
      category2: params[:category2],
      tags: params[:tags],
    )
    @playlist.save!
    if @playlist.save
    Notification.create(
      user_id: @video.user.id,
      body: "Your video '#{view_context.link_to @video.title, video_path(@video)}' was added to #{view_context.link_to @playlist.user.name, user_path(@playlist.user)}'s playlist '#{view_context.link_to @playlist.title, playlist_path(@playlist)}'."
    )
  end
    @first_item = Item.new(
      playlist_id: @playlist.id,
      video_id: @video.id
    )
    @first_item.save!
    redirect_to playlist_path(@playlist)
end

def addtoplaylist
    @video = Video.find_by_id(params[:video_id])
    @playlist = Playlist.find_by_id(params[:playlist])
    @count = @playlist.items.count
    @new_item = Item.new(
      playlist_id: @playlist.id,
      video_id: @video.id,
      sort: @count + 1
    )
    @new_item.save!
    if @new_item.save
    Notification.create(
      user_id: @video.user.id,
      body: "Your video '#{view_context.link_to @video.title, video_path(@video)}' was added to #{view_context.link_to @playlist.user.name, user_path(@playlist.user)}'s playlist '#{view_context.link_to @playlist.title, playlist_path(@playlist)}'."
    )
  end
    redirect_to playlist_path(@playlist)
end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def playlist_params
      params.require(:playlist).permit(:user_id, :title, :description, :category1, :category2, :tags, :plays)
    end
end
