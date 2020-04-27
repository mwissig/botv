class BulbsController < ApplicationController
  before_action :set_bulb, only: [:show, :edit, :update, :destroy]
  before_action :find_bulbable, only: :create

  # GET /bulbs
  # GET /bulbs.json
  def index
    @bulbs = Bulb.all
  end

  # GET /bulbs/1
  # GET /bulbs/1.json
  def show
  end

  # GET /bulbs/new
  def new
    @bulb = Bulb.new
  end

  # GET /bulbs/1/edit
  def edit
  end

  # POST /bulbs
  # POST /bulbs.json
  def create
    @bulb = @bulbable.bulbs.new bulb_params
    @bulb.user_id = current_user.id
    @bulb.save!
      if @bulb.save
        @bulb.bulbable.updated_at = DateTime.now
        @bulb.bulbable.save!
        if @bulb.bulbable_type == "Video"
          if @bulb.bulbable.comments.count == 0 && @bulb.bulbable.bulbs.where(color: "green").count == 0 && @bulb.bulbable.bulbs.where(color: "red").count >= 5
            @bulb.bulbable.destroy!
            respond_to do |format|
              format.html { redirect_to bulbs_url, notice: 'Bulb was successfully destroyed.' }
              format.js   { render :js => "alert('Your vote delete the video: #{@bulb.bulbable.title}')" }
            end
          end
        end
    end
    respond_to do |format|
      format.html { redirect_to bulbs_url, notice: 'Bulbed' }
      format.json { head :no_content }
    end


        # redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /bulbs/1
  # PATCH/PUT /bulbs/1.json
  def update
    respond_to do |format|
      if @bulb.update(bulb_params)
        format.html { redirect_to @bulb, notice: 'Bulb was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulb }
      else
        format.html { render :edit }
        format.json { render json: @bulb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulbs/1
  # DELETE /bulbs/1.json
  def destroy
    @bulb.destroy
    respond_to do |format|
      format.html { redirect_to bulbs_url, notice: 'Bulb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulb
      @bulb = Bulb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bulb_params
      params.require(:bulb).permit(:color)
    end

    def find_bulbable
  if params[:comment_id]
    @bulbable = Comment.find_by_id(params[:comment_id])
  elsif params[:video_id]
    @bulbable = Video.find_by_id(params[:video_id])
  elsif params[:playlist_id]
    @bulbable = Playlist.find_by_id(params[:playlist_id])
  end
end
end
