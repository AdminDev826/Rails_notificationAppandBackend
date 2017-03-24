class SubscribeToNewsletterBusiness
  def initialize(business)
    @business = business
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @md5_email = Digest::MD5.hexdigest(@business.email)
    @list_id = ENV['MAILCHIMP_LIST_BUSINESS']
  end

  def run
    begin
      @gibbon.lists(@list_id).members(@md5_email).upsert(
        body: {
          email_address: @business.email,
          status: "subscribed",
          double_optin: false,
          update_existing: true,
          merge_fields: {
            NAME: @business.name,
            CITY: @business.city
          }
        }
      )
    rescue Gibbon::MailChimpError => exception
      Rails.logger.error("Erreur lors inscription MAILCHIMP_LIST_BUSINESS #{exception.status_code} : #{exception.detail}")
    end
  end
end
