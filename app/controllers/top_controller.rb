class TopController < ApplicationController
  def viewed
    if current_user.permission.is_horny?
        @videos = Video.order('plays DESC').paginate(:page => params[:page], :per_page => 21)
      else
        @videos = Video.where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('plays DESC').paginate(:page => params[:page], :per_page => 21)
      end
        @bulb = Bulb.new
  end

  def loved
        if current_user.permission.is_horny?
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
          else
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'green'}).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
          end
            @bulb = Bulb.new
  end

  def hated
        if current_user.permission.is_horny?
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
          else
            @videos = Video.joins(:bulbs).where(bulbs: {color: 'red'}).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
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
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
  else
    @videos = Video.where(id: @cont.map(&:id)).joins(:bulbs).group('videos.id').where.not('category1 = ?', 'NSFW').where.not('category2 = ?', 'NSFW').order('count(bulbs.id) DESC').paginate(:page => params[:page], :per_page => 21)
  end
    @bulb = Bulb.new
  end

end
