class SubscribeToNewsletter
  def initialize(newsletter)
    @newsletter = newsletter
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @md5_email = Digest::MD5.hexdigest(@newsletter[:email])
    @list_id = ENV['MAILCHIMP_LIST_NEWSLETTER']
  end

  def run
    begin
      @gibbon.lists(@list_id).members(@md5_email).upsert(
        body: {
          email_address: @newsletter[:email],
          status: "subscribed",
          double_optin: false,
        }
      )
      @result = '<span class="info-newsletter">Félicitations ! Vous êtes inscrit.</span>'
    rescue Gibbon::MailChimpError => exception
      Rails.logger.error("Erreur lors de votre inscription  MAILCHIMP_LIST_NEWSLETTER #{exception.status_code} : #{exception.detail}")
      case exception.title
      when "Invalid Resource"
        @error = '<span class="error-newsletter"> Vérifiez le format de votre email !</span>'
      when "Member Exists"
        @error = '<span class="error-newsletter"> Vous êtes déjà inscrit !</span>'
      else
        @error = '<span class="error-newsletter"> Erreur lors de votre inscription </span>'
      end
    end
  end
end
