class Order < ApplicationRecord
    after_create_commit :schedule_remainder_review
    # has_many :products, foreign_key: product_id
    belongs_to :product
    belongs_to :customer

    # this for active job example 
    def schedule_remainder_review
        ReviewRemainderJob.set(wait:7.seconds).perform_later(customer_id)
    end
    
end
