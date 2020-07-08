class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:contact, :privacy]
  def home
    @video = Video.new
    if current_user.permission.is_horny?
          @videos = Video.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
    else
    @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
  end
    @bulb = Bulb.new
  end

def contact
end

def privacy
end

  def mod
    @flags = Flag.where(closed: false).order("created_at ASC").paginate(:page => params[:page], :per_page => 5)
    @notification = Notification.new
      @users = User.all.order("name ASC")
      @users.each do |user|
        if user.permission == nil
          @permission = Permission.new(
            user_id: user.id
          )
          @permission.save!
        end
  end
  end

  def togglemod
    if current_user.permission.is_admin?

    @user = User.find_by_id(params[:id])
    @user.permission.toggle(:is_mod).save
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_url, notice: "#{@user.name} mod status changed" }
        format.json { render :admin, status: :created, location: @user }
      else
        format.html { render :admin }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end
  end

  def admin
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 25)
     @mods = User.joins(:permission).where(permissions: {is_mod: true})
     @admins = User.joins(:permission).where(permissions: {is_admin: true})
  end

  def sources
  end

  def rules
    @users = User.all.order("name ASC")
     @mods = User.joins(:permission).where(permissions: {is_mod: true})
     @admins = User.joins(:permission).where(permissions: {is_admin: true})
  end

def category

  @query = params[:query]
  if current_user.permission.is_horny?
    @videos = Video.where(category1: @query).or(Video.where(category2: @query)).order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
    else
          @videos = Video.where(category1: @query).or(Video.where(category2: @query)).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
        @bulb = Bulb.new
end

def twocats
  @query1 = params[:query1]
    @query2 = params[:query2]
      if current_user.permission.is_horny?
    @videos = Video.where("category1 = ? and category2 = ?", @query1, @query2).or(Video.where("category1 = ? and category2 = ?", @query2, @query1)).order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
else
  @videos = Video.where("category1 = ? and category2 = ?", @query1, @query2).or(Video.where("category1 = ? and category2 = ?", @query2, @query1)).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
end
        @bulb = Bulb.new
end


end
