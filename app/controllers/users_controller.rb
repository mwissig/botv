class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :stats, :bulbs, :videos, :playlsits, :bulbsgiven, :bulbstaken]
  def show
    @user = User.find(params[:id])
    @comments = @user.comments.order("created_at DESC").first(10)
    @array = []
    @videos = @user.videos.each do |parent|
      @array << parent.bulbs
    end

    @comments = @user.comments.each do |parent|
      @array << parent.bulbs
    end

    @playlists = @user.playlists.each do |parent|
      @array << parent.bulbs
    end
if !@array[0].nil?
@bulbs_to_user = Bulb.where(id: @array[0].map(&:id))
else
  @bulbs_to_user = 0
end
      if current_user.permission.is_horny?
    @videos = @user.videos.order("created_at DESC").first(10)
    @playlists = @user.playlists.order("created_at DESC").first(10)
  else
    @videos = @user.videos.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").first(10)
    @playlists = @user.playlists.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").first(10)
  end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

    def stats
    end

def videos
  if current_user.permission.is_horny?
      @videos = @user.videos.order("created_at DESC").first(10).paginate(:page => params[:page], :per_page => 24)
    else
        @videos = @user.videos.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
    end
end

def playlists

end

    def bulbs

      @bulbs = @user.bulbs
      @redbulbs = @bulbs.where(color: "red")
      @greenbulbs = @bulbs.where(color: "green")
      all_color_values = Bulb.order(:color).pluck(:color).uniq
      @given_bulbs = all_color_values.map do |color|
        { name: color, data: @bulbs.where(color: color).group_by_week(:created_at).count }
      end
      @given_bulbs_pie = @bulbs.group(:color).count

      @array = []
      @videos = @user.videos.each do |parent|
        @array << parent.bulbs
      end

      @comments = @user.comments.each do |parent|
        @array << parent.bulbs
      end

      @playlists = @user.playlists.each do |parent|
        @array << parent.bulbs
      end
if !@array[0].nil?
@bulbs_to_user = Bulb.where(id: @array[0].map(&:id))
@display_to_user = true
      @bulbs_to_user_pie = @bulbs_to_user.group(:color).count
else
@bulbs_to_user = Bulb.all
@display_to_user = false
end
      @recieved_bulbs = all_color_values.map do |color|
        { name: color, data: @bulbs_to_user.where(color: color).group_by_week(:created_at).count }
      end


    end

def bulbsgiven
  @bulbs = @user.bulbs
  Bulb.all.each do |bulb|
    if bulb.bulbable_type = "Video" && Video.find_by_id(bulb.bulbable_id).nil?
      bulb.destroy!
    end
  end
  @redbulbs = @bulbs.where(color: "red")
  @greenbulbs = @bulbs.where(color: "green")
end

def bulbstaken
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
end
