class CustomerMailer < ApplicationMailer
    def welcome_email # we can add more parameters
        @customer = params[:customer] # params is json we can access it thourg the key
        mail(to:@customer.email , subject:"Welcome !!")
    end

    # method with parameter
    def remainder_review(customer)
        @customer = customer
        mail(to:@customer.email , subject:"Your Review matter a lot !!, so please give")
        
    end
end
