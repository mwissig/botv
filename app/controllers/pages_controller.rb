class PagesController < ApplicationController
  def home
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 20)
    @video = Video.new
    if current_user.permission.is_horny?
          @videos = Video.all.order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
    else
    @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
  end
    @bulb = Bulb.new
  end

  def mod
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

  def laws
    @users = User.all.order("name ASC")
     @mods = User.joins(:permission).where(permissions: {is_mod: true})
     @admins = User.joins(:permission).where(permissions: {is_admin: true})
  end

def category

  @query = params[:query]
  if current_user.permission.is_horny?
    @videos = Video.where(category1: @query).or(Video.where(category2: @query)).order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
    else
          @videos = Video.where(category1: @query).or(Video.where(category2: @query)).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
    end
      @bulb = Bulb.new
        @bulb = Bulb.new
end

def twocats
  @query1 = params[:query1]
    @query2 = params[:query2]
      if current_user.permission.is_horny?
    @videos = Video.where("category1 = ? and category2 = ?", @query1, @query2).or(Video.where("category1 = ? and category2 = ?", @query2, @query1)).order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
else
  @videos = Video.where("category1 = ? and category2 = ?", @query1, @query2).or(Video.where("category1 = ? and category2 = ?", @query2, @query1)).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order("created_at ASC").paginate(:page => params[:page], :per_page => 21)
end
        @bulb = Bulb.new
end


end
