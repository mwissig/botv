class PagesController < ApplicationController
  def home
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 20)
    @video = Video.new
    @videos = Video.all
    @bulb = Bulb.new
  end

  def asc
        @users = User.includes(:status).order("statuses.rating ASC").paginate(:page => params[:page], :per_page => 20)
  end

  def desc
        @users = User.includes(:status).order("statuses.rating DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def recent
        @users = User.includes(:status).order("statuses.updated_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

end
