class Customer < ApplicationRecord
    def check_email
        # check if it is precent
        if email.present?
            return true
        else
            return false
        end
    #customer= Customer.all.limit(3);
    end


    def name_check
        # check name has onlyy alphabetic value
        if name =~ /\A[a-zA-Z]+\z/   
            return true
        else
            return false
        end
    end

end

# To get output you can use below code in rails console

# --> customer = Customer.first
# --> customer.name_check