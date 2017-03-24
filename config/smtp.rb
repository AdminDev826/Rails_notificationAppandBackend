# config/initializers/smtp.rb
ActionMailer::Base.smtp_settings = {
  address: 'smtp.postmarkapp.com',
  port: '25',
  domain: 'cforgoodwebsite-production.herokuapp.com',
  user_name: ENV['POSTMARK_API_TOKEN'],
  password: ENV['POSTMARK_API_TOKEN'],
  authentication: :cram_md5,
  enable_starttls_auto: true
}
