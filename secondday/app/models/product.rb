class Product < ApplicationRecord
    has_rich_text :review #the column name u want to give


validates :name, presence: true, length:{maximum: 30, minimum: 4} 
validates :price, numericality: { greater_than_or_equal_to: 1}
validates :stock, numericality: {greater_than_or_equal_to:1}, length: {maximum: 500}
validates :description, length: {minimum: 8, maximum: 460}, format: {with: /\A[a-zA-Z0-9 ]+\z/, message: "only allows char,number and space"}
validates :is_active, presence: true , if: :price? ,acceptance:true
# validates :stock, presence: true, if: :is_active?

# '->' lamda operator

scope :whitelisted_products, -> {where("id IN (?)", [1,2, 3,4])}
scope :out_of_stock, -> { where("stock <= ?", 0) }

# ----------------------------------------------

# scope :test_scope_for_joins, -> {joins(name_of_table.where.)}
# scope :test, -> query{ }   ---->inside query we can put any sql query
# in html-----> <%= @Products.out_of_stock.count %> # to print the ruby things in webpage
# in html-----> <% @products.each do |product| %> # to embeding the ruby code
# in html-----> <%= @Products =products.whitelisted_products %>
# in html------> <% @customers = @customers.blacklisted_customers([3,5,7])%>
# in product_controlar -----> @products = Product.whitelisted_products


validate :check_is_active 
    def check_is_active
        if is_active? && (price.blank?)
            errors.add(:is_active, "cannot be checked unless price and stock are filled out")
        end
    end

    # adding error handling for validations
    def check_validity
        if description =~ /\A[a-zA-Z0-9]+\z/   
            return true
        else
            return false
        end

        # if stock==0 &&price < 0
        #   errors.add " Enter valid price and stock"
        # end
    end

    def check_availability
        if stock > 0
            true
        else
            false
        end
        # ckeck  for the stock availabel more than 0
    end

    def apply_discount(discount_percentage)
        # use case statements and calulation discount on price
        discounted_price = price - (price * discount_percentage / 100)
        return discounted_price
    end

    def total_amount
        # call the check_availability and then apply_discount use any math(round) and use to calculate the total amount
        if check_availability
            return apply_discount(10).round
        else
            return "item is not available"
        end
    end
end



