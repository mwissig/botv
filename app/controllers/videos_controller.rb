class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
        @comment = Comment.new
        @bulb = Bulb.new
        @tags = @video.tags.split(",")
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  def check
    @categories = [
      "ASMR",
      "Accidents & Explosions",
      "Advertisements",
      "Animals",
      "Animation",
      "Arts",
      "Business",
      "Clips",
      "Crime",
      "Dance",
      "Dashcam",
      "Economics",
      "Educational",
      "Fashion",
      "Food",
      "Full-length",
      "Health",
      "Humor",
      "I Made This",
      "Memes",
      "Military",
      "Movies",
      "Music",
      "Music Video",
      "Nerds",
      "News & Politics",
      "Performance",
      "Religion",
      "Science & Tech",
      "Short Films",
      "Sports",
      "Stunts",
      "TV",
      "Toys & Games",
      "Trailers",
      "Video Games"
    ]
    @videos = Video.all
    @video = Video.new
    @url = params[:url]
    @query = VideoInfo.new(@url)
    if @query.provider == "YouTube"

#  response = HTTParty.get("https://www.googleapis.com/youtube/v3/videos?part=snippet&id=" + @query.video_id + "&fields=items(snippet(title))&key=" + ENV['youtube_key'])
response = "YouTube"
      @title = response
    else
      @title = @query.title
    end
    @dupes = @videos.where("provider = ? and id_code = ?", @query.provider, @query.video_id)
  end

  def tags
    @tag = params[:query]
    @videos = Video.where("tags like ?", "%#{@tag}%")
    @comment = Comment.new
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
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
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
      params.require(:video).permit(:user_id, :id_code, :provider, :title, :duration, :description, :thumbnail, :embed_url, :embed_code, :tags, :category1, :category2, :upbulbs, :downbulbs)
    end
end
