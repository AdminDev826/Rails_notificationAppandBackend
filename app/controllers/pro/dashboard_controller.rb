class Pro::DashboardController < Pro::ProController

  skip_after_action :verify_authorized, only: :set_impersonation
  before_action :find_business, only: [:dashboard, :profile]

  def set_impersonation
    if current_business.supervising?(params[:impersonate_id])
      session[:impersonate_id] = params[:impersonate_id]
    else
      session[:impersonate_id] = nil
    end
    redirect_to pro_business_dashboard_path(current_business)
  end

  def dashboard
    @perks = @business.perks
    authorize @business
  end

  def profile
    5.times{ @business.addresses.build }
    authorize @business
  end

  def supervisor_dashboard
    @business = current_business
    # A modifier !!!
    # @perks = @business.businesses_perks
    authorize @business

    @geojson = {"type" => "FeatureCollection", "features" => []}

    if current_business.admin
      @businesses = Business.all.includes(:addresses, :business_category, :perks).eager_load(:businesses_perks, :businesses_perks_uses)
    else
      @businesses = @business.businesses.includes(:addresses, :business_category, :perks).eager_load(:businesses_perks, :businesses_perks_uses)
    end

    @businesses.each do |business|
      # BUSINESS ADDRESSES
      addresses = []
      # Main shop address
      addresses << [0, business.longitude, business.latitude, business.street] if business.shop
      # Other addresses
      business.addresses.each do |address|
        # shop
        addresses << [address.id, address.longitude, address.latitude, address.street] if business.shop and !address.day.present?
        # itinerant
        addresses << [address.id, address.longitude, address.latitude, address.street] if business.itinerant and address.day.present?
      end

      # LOAD ADDRESSES
      addresses.uniq!
      addresses.each do |address|
        @geojson["features"] << {
          "type": 'Feature',
          "geometry": {
            "type": 'Point',
            "coordinates": [address[1], address[2]],
          },
          "properties": {
            "marker-symbol": business.business_category.marker_symbol
          }
        }
      end
    end
  end

  private

  def find_business
    id = session[:impersonate_id] || params[:business_id]
    @business = Business.includes(:manager).find(id)
  end
end
