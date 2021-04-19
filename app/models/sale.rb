class Sale < ApplicationRecord
  belongs_to :drink
  
  scope :sales_at_last_year, -> {where(:created_at =>Date.today.beginning_of_year..Date.today.end_of_year) }
end
