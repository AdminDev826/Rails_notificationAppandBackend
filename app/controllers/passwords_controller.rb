class PasswordsController < Devise::PasswordsController

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    if resource_name == :user
      member_sent_mail_path
    else
      pro_sent_mail_path
    end
  end
end
