class ReviewRemainderJob < ApplicationJob
  queue_as :default

  def perform(customer_id)
    # Do something later
    customer = Customer.find(customer_id)
    CustomerMailer.remainder_review(customer).deliver
  end
end
