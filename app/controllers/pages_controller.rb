class PagesController < ApplicationController
  def home
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 30)
  end

  def asc
        @users = User.includes(:status).order("statuses.rating ASC").paginate(:page => params[:page], :per_page => 30)
  end

  def desc
        @users = User.includes(:status).order("statuses.rating DESC").paginate(:page => params[:page], :per_page => 30)
  end

  def recent
        @users = User.includes(:status).order("statuses.updated_at DESC").paginate(:page => params[:page], :per_page => 30)
  end

end
