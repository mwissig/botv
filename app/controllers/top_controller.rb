class TopController < ApplicationController
  def viewed
    if current_user.permission.is_horny?
        @videos = Video.order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      else
        @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      end
        @bulb = Bulb.new
  end

  def viewedweek
  end

  def viewedmonth
  end

  def viewedplaylists
  end

  def loved
        if current_user.permission.is_horny?
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
          else
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
          end
            @bulb = Bulb.new
  end


def lovedweek
end

def lovedmonth
end

def lovedplaylists
  if current_user.permission.is_horny?
      @playlists = Playlist.joins(:bulbs).where(bulbs: {color: 'green'}).group('playlists.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    else
      @playlists = Playlist.joins(:bulbs).where(bulbs: {color: 'green'}).group('playlists.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
  end

  def hated
        if current_user.permission.is_horny?
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
          else
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
          end
            @bulb = Bulb.new
  end

def hatedweek
end

def hatedmonth
end

  def controversial
    @cont = []
    Video.all.each do |vid|
    if !( (( vid.bulbs.where(color:"red").count / 2 ) > ( vid.bulbs.where(color:"green").count )) && !(( vid.bulbs.where(color:"green").count / 2 ) > ( vid.bulbs.where(color:"red").count)) )
      @cont << vid
    end
  end
  if current_user.permission.is_horny?
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  else
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  end
    @bulb = Bulb.new
  end

  def controweek
  end

  def contromonth
  end

  def hot
  end


end
