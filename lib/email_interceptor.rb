class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ ENV['DEVELOPER_EMAIL'] ]
  end
end
