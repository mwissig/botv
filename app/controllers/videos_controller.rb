class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  content_security_policy false, only: :show
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').paginate(:page => params[:page], :per_page => 24)
  @bulb = Bulb.new
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
        @comment = Comment.new
        @bulb = Bulb.new
        @tags = @video.tags.split(",")
        @video.increment!(:plays)
        @video.updated_at = DateTime.now
        @video.save!
        @fullscreen = true
        @items = Item.where(video_id: @video.id)
        @playlist_ids = []
        @items.each do |item|
          @playlist_ids << item.playlist
        end
        @playlist_ids.uniq!
        @playlists = Playlist.where(id: @playlist_ids.map(&:id))
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  def search

@terms = params[:terms].downcase
@username = params[:username]

@search_videos = params[:search_videos]
@search_comments = params[:search_comments]
@search_playlists = params[:search_playlists]
@use_name = params[:use_name]

@use_title = params[:use_title]
@use_tags = params[:use_tags]
@use_description = params[:use_description]
if @use_name == nil
  @username = nil
end
@matches = []


if @use_name == "on" && @search_videos == "on"

  if @terms == nil || @terms == ""
    Video.all.each do |video|
      if video.user.name.downcase.include?(@username)
        @matches << video
      end
    end

  else

      if @use_title == "on"
        Video.all.each do |video|
          if video.title.downcase.include?(@terms) && video.user.name.downcase.include?(@username)
            @matches << video
          end
        end
      end

      if @use_tags == "on"
        Video.all.each do |video|
          if video.tags.downcase.include?(@terms) && video.user.name.downcase.include?(@username)
            @matches << video
          end
        end
      end

      if @use_description == "on"
        Video.all.each do |video|
          if video.description.downcase.include?(@terms) && video.user.name.downcase.include?(@username)
            @matches << video
          end
        end
      end

  end

elsif @use_name == "on" && @search_playlists == "on"

  if @terms == nil || @terms == ""
    Playlist.all.each do |playlist|
      if playlist.user.name.downcase.include?(@username)
        @matches << playlist
      end
    end

  else

      if @use_title == "on"
        Playlist.all.each do |playlist|
          if playlist.title.downcase.include?(@terms) && playlist.user.name.downcase.include?(@username)
            @matches << playlist
          end
        end
      end

      if @use_tags == "on"
        Playlist.all.each do |playlist|
          if playlist.tags.downcase.include?(@terms) && playlist.user.name.downcase.include?(@username)
            @matches << playlist
          end
        end
      end

      if @use_description == "on"
        Playlist.all.each do |playlist|
          if playlist.description.downcase.include?(@terms) && playlist.user.name.downcase.include?(@username)
            @matches << playlist
          end
        end
      end

  end

elsif @use_name == "on" && @search_comments == "on"

  if @terms == nil || @terms == ""
    Comment.all.each do |comment|
      if comment.user.name.downcase.include?(@username)
        @matches << comment
      end
    end

  else


        Comment.all.each do |comment|
          if comment.body.downcase.include?(@terms) && comment.user.name.downcase.include?(@username)
            @matches << comment
          end
        end


  end


end



if @search_playlists == "on" && @use_name == nil
  if @use_title == "on"
    Playlist.all.each do |playlist|
      if playlist.title.downcase.include?(@terms)
        @matches << playlist
      end
    end
  end

  if @use_tags == "on"
    Playlist.all.each do |playlist|
      if playlist.tags.downcase.include?(@terms)
        @matches << playlist
      end
    end
  end

  if @use_description == "on"
    Playlist.all.each do |playlist|
      if playlist.description.downcase.include?(@terms)
        @matches << playlist
      end
    end
  end
end




if @search_videos == "on" && @use_name == nil
  if @use_title == "on"
    Video.all.each do |video|
      if video.title.downcase.include?(@terms)
        @matches << video
      end
    end
  end

  if @use_tags == "on"
    Video.all.each do |video|
      if video.tags.downcase.include?(@terms)
        @matches << video
      end
    end
  end

  if @use_description == "on"
    Video.all.each do |video|
      if video.description.downcase.include?(@terms)
        @matches << video
      end
    end
  end
end


if @use_name == nil && @search_comments == "on"
        Comment.all.each do |comment|
          if comment.body.downcase.include?(@terms)
            @matches << comment
          end
      end
  end

@matches = @matches.uniq

 if @search_videos == "on"
@videos = Video.where(id: @matches.map(&:id)).order("created_at ASC").paginate(:page => params[:page], :per_page => 24)
elsif @search_playlists == "on"
  @playlists = Playlist.where(id: @matches.map(&:id)).order("created_at ASC").paginate(:page => params[:page], :per_page => 24)
elsif @search_comments == "on"
  @comments = Comment.where(id: @matches.map(&:id)).order("created_at ASC").paginate(:page => params[:page], :per_page => 20)
else
  @videos = nil
end

  @bulb = Bulb.new
  end

  def check

    @videos = Video.all
    @video = Video.new
    @url = params[:url]

    if (@url.include?("youtube.com") || @url.include?("vimeo.com") || @url.include?("wistia.com") || @url.include?("dailymotion.com") || @url.include?("youtu.be"))
    @query = VideoInfo.new(@url)
      @video_id = @query.video_id
      @title = @query.title
      @thumbnail = @query.thumbnail_medium
      @provider = @query.provider
      @embed_url = @query.embed_url
      @embed_code = @query.embed_code
      @duration = @query.duration
      @description = @video.description
      @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif (@url.include?("twitter.com") || @url.include?("://t.co"))
    response = HTTParty.get('https://publish.twitter.com/oembed?url=' + @url)
    @query = @url
    @video_id = @query
    @embed_url = @query
    @duration = 0
    @title = ""
    @description = ActionController::Base.helpers.sanitize(response["html"], tags:[])
    @embed_code = response["html"]
    @provider = "Twitter"
    @thumbnail = ActionController::Base.helpers.image_path("twitter.png")
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif (@url.include?("instagram.com") || @url.include?("://instagr.am"))
    response = HTTParty.get('https://api.instagram.com/oembed?url=' + @url)
    @query = @url
    @video_id = response['media_id']
    @embed_url = @query
    @duration = 0
    @title =  response["title"]
    @description = ActionController::Base.helpers.sanitize(response["html"], tags:[])
    @embed_code = response["html"]
    @provider = "Instagram"
    @thumbnail = response['thumbnail_url']
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif @url.include?("tiktok.com")
    response = HTTParty.get('https://www.tiktok.com/oembed?url=' + @url)
    @query = @url
    @video_id = @query
    @embed_url = @query
    @duration = 0
    @title =  response["title"]
    @description = response["title"]
    @embed_code = response["html"]
    @provider = "TikTok"
    @thumbnail = response['thumbnail_url']
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif (@url.include?("facebook.com") || @url.include?("://fb.com"))
    @query = @url
    if @query.include?("videos/")
      @parts = @query.split("videos/")
    elsif @query.include?("watch/?v=")
      @parts = @query.split("watch/?v=")
    end
    if @parts[1].include?("/")
    @video_id = @parts[1].chomp!("/")
  else
    @video_id = @parts[1]
  end
    @embed_url = "https://www.facebook.com/facebook/videos/" + @video_id + "/"
    @duration = 0
    @title =  @query
    @description = @query
    @embed_code = "<div id='fb-root'></div>
<script async defer crossorigin='anonymous' src='https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=403358119713189&autoLogAppEvents=1'></script>
<div class='fb-video' data-href='#{@embed_url}' data-width='auto' data-show-text='false'></div>"
    @provider = "Facebook"
    @thumbnail = ActionController::Base.helpers.image_path("facebook.png")
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif @url.include?("giphy.com/gifs")
    @query = @url
    @parts = @query.split("gifs/")
    @video_id = @parts[1]
    @embed_url = @query
    @duration = 0
    @title =  ""
    @description = ""
    @embed_code = "<div style='width:100%;height:0;padding-bottom:100%;position:relative;'><iframe src='https://giphy.com/embed/#{@video_id}' width='100%' height='100%' style='position:absolute' frameBorder='0' class='giphy-embed' allowFullScreen></iframe></div><p><a href='https://giphy.com/gifs/#{@video_id}'>via GIPHY</a></p>"
    @provider = "Giphy"
    @thumbnail = "https://media.giphy.com/media/#{@video_id}/giphy.gif"
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  elsif @url.include?("gfycat.com")
    @query = @url
    @parts = @query.split("gfycat.com/")
    @idparts = @parts[1].split("-", 2)
    @video_id = @idparts[0]
    if @idparts.length > 1
      @video_stub = "-" + @idparts[1]
    else
      @video_stub = ""
    end
    @embed_url = @query
    @duration = 0
    @title =  ""
    @description = ""
    @embed_code = "<div style='position:relative; padding-bottom:calc(48.89% + 44px)'><iframe src='https://gfycat.com/ifr/#{@video_id}' frameborder='0' scrolling='no' width='100%' height='100%' style='position:absolute;top:0;left:0;' allowfullscreen></iframe></div><p> <a href='https://gfycat.com/#{@video_id}#{@video_stub}'>via Gfycat</a></p>"
    @provider = "Gfycat"
    @thumbnail = ActionController::Base.helpers.image_path("gfycat.png")
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  else
    @query = @url
    @video_id = @query
    @embed_url = @query
    @duration = 0
    @title = ""
    @description = ""
    @embed_code = "<iframe src='#{@query}' onload='showLink()'></iframe>"
    @provider = "External"
    @thumbnail = ActionController::Base.helpers.image_path("snow.png")
    @dupes = @videos.where("provider = ? and id_code = ?", @provider, @video_id)
  end
end

  def tags
    @tag = params[:query]
  if current_user.permission.is_horny?
    @videos = Video.where("tags like ?", "%#{@tag}%").order("created_at ASC").paginate(:page => params[:page], :per_page => 24)
else
  @videos = Video.where("tags like ?", "%#{@tag}%").where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at ASC").paginate(:page => params[:page], :per_page => 24)
end
    @comment = Comment.new
    @bulb = Bulb.new
  end

  def nsfw
      @videos = Video.where(category1: 'NSFW').or(Video.where(category2: 'NSFW')).order("created_at ASC").paginate(:page => params[:page], :per_page => 24)
  @bulb = Bulb.new
    end

  # POST /videos
  # POST /videos.json
  def create
    if current_user.permission.can_post_video?
      @video = Video.new(video_params)

      respond_to do |format|
        if @video.save
          format.html { redirect_to @video, notice: 'Video was successfully created.' }
          format.json { render :show, status: :created, location: @video }
        else
          format.html { render :new }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to root_path, notice: 'You can not post videos.' }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    if @video.destroy
      @items = Item.where(video_id: @video.id)
      @items.each do |item|
          item.destroy!
          Notification.create(
            user_id: item.playlist.user.id,
            body: "The video '#{@video.title}' in your playlist #{view_context.link_to item.playlist.title, playlist_path(item.playlist)} was deleted."
          )
      end
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:user_id, :id_code, :provider, :title, :duration, :description, :thumbnail, :embed_url, :embed_code, :tags, :category1, :category2, :plays)
    end
end
