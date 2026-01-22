class Product < ApplicationRecord
    # inbuilt validations-->9th day...

validates :name, presence: true, length:{maximum: 30, minimum: 4} 
validates :price, numericality: { greater_than_or_equal_to: 1}
validates :stock, numericality: {greater_than_or_equal_to:1}, length: {maximum: 500}
validates :description, length: {minimum: 8, maximum: 460}, format: {with: /\A[a-zA-Z0-9]+\z/, message: "only allows char,number and space"}
validates :is_active, presence: true , if: :price? ,acceptance:true
validates :stock, presence: true, if: :is_active?

validate :check_is_active 
    def check_is_active
        if is_active? && !(price.blank?)
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



