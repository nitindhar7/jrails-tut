module StoreHelper
  def sort_order(order)
    if !order.blank? && order == 'ASC'
      'DESC'
    else
      'ASC'
    end
  end
end
