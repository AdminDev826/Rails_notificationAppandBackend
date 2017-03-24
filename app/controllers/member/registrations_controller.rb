class Member::RegistrationsController < Devise::RegistrationsController

  def update_cause
    current_user.update_attribute("cause_id", user_params[:cause_id])
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
  end

  def update_profile
    if user_params[:password].present?
      current_user.update(user_params)
      sign_in(current_user, bypass: true)
    else
      current_user.update_without_password(user_params)
    end
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
  end

  def stop_subscription
    current_user.stop_subscription!
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :picture, :picture_cache, :cause_id, :subscription, :birthday, :street, :zipcode, :city, :amount, :code_partner)
  end
end
