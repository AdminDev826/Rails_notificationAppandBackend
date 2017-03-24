# == Schema Information
#
# Table name: uses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  perk_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feedback   :boolean          default(FALSE)
#  like       :boolean          default(FALSE)
#  unlike     :boolean          default(FALSE)
#  unused     :boolean          default(FALSE)
#
# Indexes
#
#  index_uses_on_perk_id  (perk_id)
#  index_uses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_7057e30f7a  (perk_id => perks.id)
#  fk_rails_b60db94a9d  (user_id => users.id)
#

class UsesController < ApplicationController

  before_action :find_use, only: [:edit, :update]
  before_action :find_perk, only: [:create]

  def create
    @use = current_user.uses.new(use_params)
    @use.save
    respond_to :js
  end

  def update
    @use.update(use_params)
    respond_to do |format|
      format.html {redirect_to member_user_dashboard_path(current_user)}
      format.js {}
    end
  end

  private

  def find_perk
    @perk = Perk.find(params[:perk_id])
  end

  def find_use
    @use = Use.find(params[:id])
  end

  def use_params
    params.require(:use).permit(:id, :perk_id, :feedback, :like, :unlike, :unused)
  end

end

