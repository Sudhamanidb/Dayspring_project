class Customer < ApplicationRecord
    has_rich_text :about_me
    # validates :name, presence: true, length: {maximum: 20, minimum:3}
    # validates :email, presence: true, uniqueness: true
    # validate :deny_profanit

    # scope :unique_email, -> {distinct.where(email: "radha@gmail.com").pluck(:email)}
    scope :blacklisted_customers, ->(customer_ids) { where(id: customer_ids) }
    scope :with_email, ->(email) { where(email: email).distinct.pluck(:email) }



    def deny_profanity
        profanity_words = /lopper|nonsence|idiot/i 
        errors.add(:name, "is inappropriate") if name =~ profanity_words
        errors.add(:email, "is inappropriate") if email =~ profanity_words
    end

    def check_email
        # check if it is present
        if email.present?
            return true
        else
            return false
        end
    #customer= Customer.all.limit(3);
    end

    def check_name
        # check name has onlyy alphabetic value
        if name =~ /\A[a-zA-Z]+\z0-9/   
            return true
        else
            return false
        end
    end
end

# To get output,--> you can use below code in rails console......

# --> customer = Customer.first
# --> customer.name_check
#  we should use alias name inside model



# 23/1-->task-->create new routes 
