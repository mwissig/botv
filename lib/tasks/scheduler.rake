desc "Deletes dupe bulbs"
task :delete_dupe_bulbs => :environment do
  puts "Deleting duplicate bulbs"

  @mybulbs = Bulb.all.order("created_at ASC")
  @extrabulbs = []
  p "-------------all bulbs--------------------"
  p @mybulbs.count
  @mybulbs.each do |bulb|
    if bulb != @mybulbs.last
      @bulb_id = bulb.id
      @nextid = bulb.id + 1
      until !@mybulbs.find_by_id(@nextid).nil?
        @nextid += 1
      end
      if !@mybulbs.find_by_id(@nextid).nil?
        @next = @mybulbs.find_by_id(@nextid)
        if bulb.bulbable_type == @next.bulbable_type && bulb.bulbable_id == @next.bulbable_id && bulb.user_id == @next.user_id
          @extrabulbs << @next
          @next.destroy
        end
      end
    end
  end
  p "----------extra bulbs--------------------"
  p @extrabulbs.count
  puts "Extra bulbs deleted."
end
