class ApplicationMailer < ActionMailer::Base
  default from: "hello@cforgood.com"

  layout 'mailer'
end
