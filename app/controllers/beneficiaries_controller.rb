class BeneficiariesController < ApplicationController

  before_action :find_beneficiary, only: [:update]

  def create
    @beneficiary = current_user.beneficiaries.new(beneficiary_params)
    @beneficiary.save
    respond_to :js
  end

  def update
    @beneficiary.update(beneficiary_params)
    respond_to do |format|
      format.html {redirect_to member_user_dashboard_path(current_user)}
      format.js {}
    end
  end

  private

  def find_beneficiary
    @beneficiary = Beneficiary.find(params[:id])
  end

  def beneficiary_params
    params.require(:beneficiary).permit(:id, :user_id, :first_name, :last_name, :email, :nb_month, :amount, :used)
  end

end

