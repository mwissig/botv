class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

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

    if (@url.include?("youtube") || @url.include?("vimeo") || @url.include?("wistia") || @url.include?("dailymotion") || @url.include?("youtu.be"))
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
