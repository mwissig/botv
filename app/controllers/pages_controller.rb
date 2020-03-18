class PagesController < ApplicationController
  def home
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 50)
  end
end
