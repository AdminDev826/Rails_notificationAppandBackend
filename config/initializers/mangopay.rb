MangoPay.configure do |c|
  c.preproduction = true unless Rails.env.production?
  c.preproduction = false if Rails.env.production?
  c.client_id = ENV['MANGOPAY_CLIENT_ID']
  c.client_passphrase = ENV['MANGOPAY_CLIENT_PASSPHRASE']
end
