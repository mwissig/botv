module VideosHelper
  def link_hashtags(comment)
    comment.gsub(/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/) { |match| link_to match, match }
  end

  def redbulbers(source)
    arr = []
    source.bulbs.where(color: "red").each do |bulb|
       arr << bulb.user
    end
    return User.where(id: arr.map(&:id))
  end

  def greenbulbers(source)
    arr = []
    source.bulbs.where(color: "green").each do |bulb|
       arr << bulb.user
    end
    return User.where(id: arr.map(&:id))
  end

end
