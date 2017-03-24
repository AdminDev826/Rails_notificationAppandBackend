class Pro::PerksController < Pro::ProController

  before_action :find_perk, only: [:edit, :update, :destroy]
  before_action :find_business, only: [:index, :new, :create, :edit]

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    if session[:impersonate_id]
      @perks = Perk.where(business_id: session[:impersonate_id]).undeleted
    else
      @perks = policy_scope(Perk).undeleted
    end
  end

  def new
    @perk = Perk.new
    authorize @perk
  end

  def create
    @perk = @business.perks.build(perk_params)
    authorize @perk

    respond_to do |format|
      if @perk.save
        format.html { redirect_to pro_business_perks_path(current_business) }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @perk.update(perk_params)
        format.html { redirect_to pro_business_perks_path(current_business) }
        format.js {}
      else
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    if @perk.nb_views > 0 || @perk.uses.count > 0 || @perk.created_at < Date.today
      @perk.deleted!
    else
      @perk.destroy
    end
    redirect_to pro_business_perks_path(current_business)
  end

  private

  def find_perk
    @perk = Perk.find(params[:id])
    # authorize @perk
  end

  def find_business
    id = session[:impersonate_id] || params[:business_id] || current_business.id
    @business = Business.find(id)
  end

  def perk_params
    params.require(:perk).permit(:name, :description, :perk_detail_id, :times, :start_date, :start_date_date, :start_date_hour, :start_date_min, :end_date, :end_date_date, :end_date_hour, :end_date_min, :all_day, :perk_code, :picture, :active, :appel, :durable, :flash)
  end
end
