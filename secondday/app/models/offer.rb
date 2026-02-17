class Offer < ApplicationRecord
    has_many :products, through: :products_offers
    has_many :subscriptions 
    has_many :products , through: :subscriptions
end
