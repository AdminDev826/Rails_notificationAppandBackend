class CausesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @causes = Cause.all.includes(:cause_category)
  end

  def show
    @cause  = Cause.joins(:cause_category).find(params[:id])
  end
end
