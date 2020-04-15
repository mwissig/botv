class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  content_security_policy false, only: :show
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').paginate(:page => params[:page], :per_page => 21)
  @bulb = Bulb.new
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
        @comment = Comment.new
        @bulb = Bulb.new
        @tags = @video.tags.split(",")
        @video.increment!(:plays)
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
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
    @videos = Video.where("tags like ?", "%#{@tag}%").order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
else
  @videos = Video.where("tags like ?", "%#{@tag}%").where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
end
    @comment = Comment.new
    @bulb = Bulb.new
  end

  def nsfw
      @videos = Video.where(category1: 'NSFW').or(Video.where(category2: 'NSFW')).order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
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
