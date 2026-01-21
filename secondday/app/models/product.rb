class Product < ApplicationRecord
    # step 1 : write one methos inside model
    # step 2 : assign value
    # step 3 : use select with price condition(status col--> if this select if that reject) on price 
    # step 4 : use all and any with active inactive (price)

    @status = Product.all.limit(10).pluck(:is_active)
    @price =Product.all.limit(10).pluck(:price)
    @stock=Product.all.limit(10).pluck(:stock)
    
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
    case discount_percentage
    when 10
        discounted_price = price - (price * 0.10)
    when 20
        discounted_price = price - (price * 0.20)
    when 30
        discounted_price = price - (price * 0.30)
    else
        discounted_price = price
    end
    return discounted_price
end


def total_amount
    # call the check_availability and then apply_discount use any math(round) and use to calculate the total amount
    if check_availability
       return apply_discount(10)
    else
        return "item is not available"
    end
end
end


