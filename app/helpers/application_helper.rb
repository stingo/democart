module ApplicationHelper

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



end



