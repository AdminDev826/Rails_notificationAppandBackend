class Pro::ProController < ActionController::Base

  layout 'application'

  before_action :authenticate_business!
  include Pundit

  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(pro_business_dashboard_path(current_business))
  end

  def pundit_user
    current_business
  end

  def current_impersonation
    return nil unless session[:impersonate_id].present?
    @current_impersonation ||= Business.find(session[:impersonate_id])
  end
end
