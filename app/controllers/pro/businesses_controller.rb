class Pro::BusinessesController < Pro::ProController

  skip_after_action :verify_authorized

  def new
    if current_impersonation
      @error = "Vous essayez de créer un commerce, nous vous avons déconnecté de #{current_impersonation.name}"
    end
    session[:impersonate_id] = nil
    @business = Business.new
  end

  def create
    @business = current_business.businesses.build(business_params)
    @business.password = 'cforgood'
    if @business.save
      session[:impersonate_id] = @business.id
      redirect_to pro_business_profile_path(current_business)
    else
      @error = "Echec de la création du commerce"
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :email, :city, :zipcode, :business_category_id)
  end
end
