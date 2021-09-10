# frozen_string_literal: true

# The search facade
class SearchFacade

  def self.get_item(input)
    item = find_item(input)
    if item == nil
      ErrorDataRecord.new("No item found with input", "NOT FOUND", 404)
    else
      item
    end
  end

  def self.find_item(input)
    if input[:name]
      Item.name_query(input[:name])
    elsif input[:min_price] && input[:max_price]
      Item.range_price_query(input[:min_price], input[:max_price])
    elsif input[:min_price]
      Item.min_price_query(input[:min_price])
    elsif input[:max_price]
      Item.max_price_query(input[:max_price])
    end
  end
end
