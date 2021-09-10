# frozen_string_literal: true

# Item controller facade
class ItemFacade
  def self.get_items(page, per_page)
    if page.to_i.positive? && per_page
      Item.all.paginate(page: page, per_page: per_page)
    elsif page.to_i.positive?
      Item.all.paginate(page: page, per_page: 20)
    elsif per_page
      Item.all.paginate(page: 1, per_page: per_page)
    else
      Item.all.paginate(page: 1, per_page: 20)
    end
  end
end
