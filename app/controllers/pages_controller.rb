class PagesController < ApplicationController

  before_action :redirect_to_dashboard!

  skip_before_action :authenticate_user!, only: [:newsletter, :faq_connect]

  def newsletter
    @result = SubscribeToNewsletter.new(params[:newsletter]).run
    respond_to do |format|
      format.html {redirect_to :back}
      format.js { @result }
    end
  end

  def faq_connect
    return redirect_to root_path unless current_business || current_user
  end

  private

  def redirect_to_dashboard!
    if request['action'] != "faq_connect"
      return redirect_to(member_user_dashboard_path(current_user)) if user_signed_in?
      return redirect_to(pro_business_dashboard_path(current_business)) if business_signed_in?
    end
  end

end
