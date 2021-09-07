# frozen_string_literal: true

# Merchant controller facade
class MerchantFacade
  def self.get_merchants(page, per_page)
    if page.to_i.positive? && per_page
      Merchant.all.paginate(page: page, per_page: per_page)
    elsif page.to_i.positive?
      Merchant.all.paginate(page: page, per_page: 20)
    elsif per_page
      Merchant.all.paginate(page: 1, per_page: per_page)
    else
      Merchant.all.paginate(page: 1, per_page: 20)
    end
  end
end
