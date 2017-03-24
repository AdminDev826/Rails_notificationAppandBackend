class BusinessMailerPreview < ActionMailer::Preview
  def registration
    business = Business.first
    BusinessMailer.registration(business)
  end

  def activation
    business = Business.first
    BusinessMailer.activation(business)
  end
end
