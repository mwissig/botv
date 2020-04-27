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
    if current_user.permission.is_horny?
        @videos = Video.where("created_at >= ?", 7.days.ago).order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      else
        @videos = Video.where("created_at >= ?", 7.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      end
        @bulb = Bulb.new
  end

  def viewedmonth
    if current_user.permission.is_horny?
        @videos = Video.where("created_at >= ?", 30.days.ago).order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      else
        @videos = Video.where("created_at >= ?", 30.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      end
        @bulb = Bulb.new
  end

  def viewedplaylists
    if current_user.permission.is_horny?
        @playlists = Playlist.order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      else
        @playlists = Playlist.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      end
        @bulb = Bulb.new
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
  if current_user.permission.is_horny?
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where("videos.created_at >= ?", 7.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    else
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where("videos.created_at >= ?", 7.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
end

def lovedmonth
  if current_user.permission.is_horny?
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where("videos.created_at >= ?", 30.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    else
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where("videos.created_at >= ?", 30.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
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
  if current_user.permission.is_horny?
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where("videos.created_at >= ?", 7.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    else
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where("videos.created_at >= ?", 7.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
end

def hatedmonth
  if current_user.permission.is_horny?
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where("videos.created_at >= ?", 30.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    else
      @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where("videos.created_at >= ?", 30.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
    end
      @bulb = Bulb.new
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
    @cont = []
    Video.all.each do |vid|
    if !( (( vid.bulbs.where(color:"red").count / 2 ) > ( vid.bulbs.where(color:"green").count )) && !(( vid.bulbs.where(color:"green").count / 2 ) > ( vid.bulbs.where(color:"red").count)) )
      @cont << vid
    end
  end
  if current_user.permission.is_horny?
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where("videos.created_at >= ?", 7.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  else
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where("videos.created_at >= ?", 7.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  end
    @bulb = Bulb.new
  end

  def contromonth
    @cont = []
    Video.all.each do |vid|
    if !( (( vid.bulbs.where(color:"red").count / 2 ) > ( vid.bulbs.where(color:"green").count )) && !(( vid.bulbs.where(color:"green").count / 2 ) > ( vid.bulbs.where(color:"red").count)) )
      @cont << vid
    end
  end
  if current_user.permission.is_horny?
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where("videos.created_at >= ?", 30.days.ago).order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  else
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where("videos.created_at >= ?", 30.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 24)
  end
    @bulb = Bulb.new
  end

  def hot
    if current_user.permission.is_horny?
        @videos = Video.where("updated_at >= ?", 1.days.ago).order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      else
        @videos = Video.where("updated_at >= ?", 1.days.ago).where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 24)
      end
        @bulb = Bulb.new
  end


end
