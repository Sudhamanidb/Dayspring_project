class User < ApplicationRecord
    has_one :Vendor ,dependent: :destroy
end
