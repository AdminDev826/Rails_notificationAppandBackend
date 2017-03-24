class Member::SubscribeController < ApplicationController

  before_action :authenticate_user!

  def new
    @cause = Cause.all.includes(:cause_category)
  end

  def create
    if current_user.mangopay_id
      current_user.update_attribute("card_id", params[:card][:id])
      execute_payin
    end
    respond_to :js
  end

  def update
    if current_user.update_without_password(user_params)
      if current_user.card_id
        execute_payin
      end
    end
  end

  def destroy
    if current_user.user_histories.last.code_partner == current_user.code_partner
      current_user.user_histories.last.delete
      current_user.code_partner = nil
      current_user.date_end_partner = nil
      current_user.save
      current_user.user_histories.last.delete
    end
    respond_to :js
  end

  def gift
  end

  private

  def execute_payin
    if request.referer.include?('gift')
      flash[:success] = "Vos données bancaires ont bien été enregistrées."
      if !current_user.member
        current_user.code_partner = "SIGNUPGIFT"
        current_user.member!
      end
    else
      if current_user.should_payin? || ( params['commit'] == "M'abonner" || params['commit'] == "Me réabonner" )
        wallet_id = Cause.find_by_id(current_user.cause_id).wallet_id if current_user.cause_id
        wallet_id = ENV['MANGOPAY_CFORGOOD_WALLET_ID'] unless wallet_id
        result = MangopayServices.new(current_user).create_mangopay_payin(wallet_id)
        if result["ResultMessage"] == "Success"
          @payment = current_user.payments.new(cause_id: current_user.cause_id, amount: current_user.amount, subscription: current_user.subscription, done: true)
          if @payment.save
            current_user.member!
            current_user.update(date_last_payment: Time.now, code_partner: nil, date_end_partner: nil)
            flash[:success] = "Votre paiement a été pris en compte."
          else
            flash[:alert] = "Erreur lors de l'enregistrement de votre paiement."
          end
        else
          flash[:alert] = result["ResultMessage"]
          message = current_user.find_name_or_email? + ": *erreur lors du paiement* :" + (result["ResultMessage"] || "")
          send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)
        end
      elsif current_user.subscription.present?
        flash[:success] = "Vos données bancaires ont bien été enregistrées."
        current_user.member!
      end
    end
  end

  def card_params
    params.require(:card).permit(:id)
  end

  def user_params
    params.require(:user).permit(:subscription, :amount, :code_partner)
  end
end
