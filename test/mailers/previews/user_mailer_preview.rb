class UserMailerPreview < ActionMailer::Preview
  def registration
    user = User.first
    UserMailer.registration(user)
  end

  def activation
    user = User.first
    UserMailer.activation(user)
  end
end
