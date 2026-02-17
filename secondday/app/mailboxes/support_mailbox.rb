class SupportMailbox < ApplicationMailbox
  def process
    # this method is for processing incoming emails
    # mail.decode -->this will be the body
    # mail.from -->sender
    # mail.subject -->subject
  end
end
