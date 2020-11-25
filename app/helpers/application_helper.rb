module ApplicationHelper

def mp3_size
  number_to_human_size(@song.mp3_audio.byte_size)
end
  def current_ordering
    # Use Find by id to avoid potential erros
    if Ordering.find_by_id(session[:ordering_id]).nil?
      Ordering.new
    else
      Ordering.find_by_id(session[:ordering_id])
    end
  end


def avataryze(name)
    as_array = name.split(' ')
    if as_array.length >= 2 then (as_array[0][0] + as_array[1][0]).upcase else name[0..1].upcase end
  end


def cart_count_over_one
return total_cart_items if total_cart_items > 0
end



  def total_cart_items
    total = @order_items.map(&:quantity).sum
    return total if total > 0
  end

def current_ordering_items
	@order_items = current_ordering.order_items
end


def items_count
	@order_items.sum(:quantity)	
end

  def ads_with_logic(n_songs, ads, diff=2)
    return false if(n_songs <= 0 || !ads.present?)

    n_ads = ads.count
    n_ads_slot = n_songs/diff

    selected_ads = []
    if n_ads_slot >= n_ads
      ads_with_level = [ads.High.shuffle, ads.Medium.shuffle, ads.Low.shuffle]

      selected_ads = ads_with_level[0] + ads_with_level[1] + ads_with_level[2]


      n_ads_slot -= selected_ads.count

      while n_ads_slot > 0
        (0..2).each do |i|
          if ads_with_level[i].count >= n_ads_slot
            n_ads_slot = 0
            selected_ads += ads_with_level[i].shuffle[0..n_ads_slot-1]
          else
            selected_ads += ads_with_level[i]
            n_ads_slot -= ads_with_level[i].count
          end
          break if n_ads_slot <= 0
        end
      end
    else

      formula = [(n_ads_slot/3)+1,
                 (n_ads_slot/3),
                 (n_ads_slot - (n_ads_slot/3)+1 - (n_ads_slot/3))
      ]

      ads_count = [ ads.High.count, ads.Medium.count, ads.Low.count ]

      limits = [
          formula[0],
          formula[1],
          formula[2]
      ]

      (0..2).each do |i|
        if limits[i] > ads_count[i]
          limits[i] = ads_count[i]
          ads_count[i] = 0
        else
          ads_count[i] -= limits[i]
        end
      end

      n_ads_slot -=  limits.sum

      while n_ads_slot > 0
        (0..2).each do |i|
          if(ads_count[i] - n_ads_slot) >= 0
            tmp = n_ads_slot
            ads_count[i] -= n_ads_slot
          elsif ads_count[i] > 0
            tmp = ads_count[i]
            ads_count[i] = 0
          else
            tmp = 0
          end
          n_ads_slot -= tmp
          limits[i] += tmp
          break if n_ads_slot <= 0
        end
      end

      selected_ads += ads.High.shuffle[0..limits[0]-1]
      selected_ads += ads.Medium.shuffle[0..limits[1]-1]
      selected_ads += ads.Low.shuffle[0..limits[2]-1]
    end

    selected_ads
  end

end



