module ApplicationHelper

  include Mobvious::Rails::Helper

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    if user.picture # si le user est connecté avec fb
      user.picture.url(:avatar)  # on affiche img de profile
    else          # sinon on utilise gravatar pr son email
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=30"
    end
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def pro_space?
    request.env['PATH_INFO'].include?("/pro/") ||
    request.env['PATH_INFO'].include?("/landing_business") ||
    (business_signed_in? && request.path == "/faq_connect")
  end

  def asso_space?
    request.env['PATH_INFO'].include?("/landing_cause")
  end

  def user_space?
    !pro_space?
  end

  def landing_page?
    request.path == "/" ||
    request.path == "/landing_business" ||
    request.path == "/landing_cause"
  end

  def signup_or_signin_page?
    request.path == "/" ||
    request.path == "/users" ||
    request.path == "/signin" ||
    request.path == "/signup" ||
    request.path == "/signup_gift" ||
    request.path == "/signup_beneficiary" ||
    request.path == "/member/signin" ||
    request.path == "/users/sign_in" ||
    request.path == "/member/signup" ||
    request.path == "/member/signup/new" ||
    request.path == "/pro" ||
    request.path == "/pro/sign_in" ||
    request.path == "/pro/sign_up"
  end

  def pad0 items
    if items.class == Range || items.class == Array
      items.map { |item| item.to_s.rjust(2, '0') }
    else
      items.to_s.rjust(2, '0')
    end
  end

  def navbar_classes
    classes = []
    classes << "flash" if landing_page?
    classes << "nav-user" if user_space? && user_signed_in?
    classes << "nav-business" if !user_space? && business_signed_in?

    return classes.join(' ')
  end

  def pages_controller?
    controller_name == "pages"
  end

  def devise_or_pages_controller?
    devise_controller? || controller_name == "pages"
  end

  def navbar_logo
    if devise_or_pages_controller?
      "logo-white.png"
    else
      "cforgood_logo.png"
    end
  end

  def navbar_logo_link
    if user_signed_in?
      member_user_dashboard_path(current_user)
    elsif business_signed_in?
      pro_business_dashboard_path(current_business)
    else
      root_path
    end
  end

  def current_impersonation
    return nil unless session[:impersonate_id].present?
    @current_impersonation ||= Business.find(session[:impersonate_id])
  end

end
