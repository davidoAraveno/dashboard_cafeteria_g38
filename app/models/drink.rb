class Drink < ApplicationRecord
       has_many :sales

       def sales_at_mont(sales)
              total_sales = 0
              sales.each do |sale|
                     total_sales += sale.total
              end
              return total_sales
       end
end
