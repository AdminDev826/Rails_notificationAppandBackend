class SubscribeToNewsletterCause
  def initialize(cause)
    @cause = cause
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @md5_email = Digest::MD5.hexdigest(@cause.email)
    @list_id = ENV['MAILCHIMP_LIST_CAUSE']
  end

  def run
    begin
      @gibbon.lists(@list_id).members(@md5_email).upsert(
        body: {
          email_address: @cause.email,
          status: "subscribed",
          double_optin: false,
          update_existing: true,
          merge_fields: {
            NAME: @cause.name,
            CITY: @cause.city
          }
        }
      )
    rescue Gibbon::MailChimpError => exception
      Rails.logger.error("Erreur lors inscription MAILCHIMP_LIST_CAUSE #{exception.status_code} : #{exception.detail}")
    end
  end
end
