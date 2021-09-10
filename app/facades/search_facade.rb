# frozen_string_literal: true

# The search facade
class SearchFacade
  def self.get_item(input)
    if input[:name]
      Item.name_query(input[:name])
    end
  end
end
