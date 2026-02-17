class ProductMailer < ApplicationMailer
    def welcome_product # we can add more parameters
        @product = params[:product] # params is json we can access it thourg the key
        mail(to:@product.email , subject:"Welcome !!")
    end
end  

