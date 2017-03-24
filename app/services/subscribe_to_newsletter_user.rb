class SubscribeToNewsletterUser
  def initialize(user)
    @user = user
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @md5_email = Digest::MD5.hexdigest(@user.email)
    @list_id = ENV['MAILCHIMP_LIST_USER']
  end

  def run
    begin
      @gibbon.lists(@list_id).members(@md5_email).upsert(
        body: {
          email_address: @user.email,
          status: "subscribed",
          double_optin: false,
          update_existing: true,
          merge_fields: {
            FNAME: @user.first_name,
            LNAME: @user.last_name,
            CITY: @user.city
          }
        }
      )
    rescue Gibbon::MailChimpError => exception
      Rails.logger.error("Erreur lors inscription MAILCHIMP_LIST_USER #{exception.status_code} : #{exception.detail}")
    end
  end
end

