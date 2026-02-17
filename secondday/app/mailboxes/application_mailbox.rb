class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing all: :support
  # routing @customer_care  -->@customer_care instead of this we can use any domain
end
