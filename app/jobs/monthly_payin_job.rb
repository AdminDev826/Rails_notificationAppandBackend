class MonthlyPayinJob < ApplicationJob
  queue_as :default

  def perform

    report = []
    report << "-----------------------------------------"

    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])


    # Traitment members on trial at J-7
    report << "MEMBER ON TRIAL J-7"
    report << "-----------------------------------------"

    @user_trial_J_7 = User.member_on_trial_should_payin(7)
    nb_events_trial_J_7 = 0

    @user_trial_J_7.each do |user|
      if !user.card_id.present?
        begin
          intercom.events.create(
            event_name: "TRIAL-J-7",
            created_at: Time.now.to_i,
            user_id: user.id,
            email: user.email
          )
        rescue Intercom::IntercomError => e
          puts e
        end
        nb_events_trial_J_7 += 1
        report << "MEMBER ON TRIAL J-7 | event intercom | #{user.id} | #{user.email}"
      end
    end

    report << "-----------------------------------------" if @user_trial_J_7.present?
    report << "Nb users on trial J-7 | #{@user_trial_J_7.size}"
    report << "Nb events for trial J-7 | #{nb_events_trial_J_7}"
    report << "-----------------------------------------"


    # Traitment members on trial at J-3
    report << "MEMBER ON TRIAL J-3"
    report << "-----------------------------------------"

    @user_trial_J_3 = User.member_on_trial_should_payin(3)
    nb_events_trial_J_3 = 0

    @user_trial_J_3.each do |user|
      if !user.card_id.present?
        begin
          intercom.events.create(
            event_name: "TRIAL-J-3",
            created_at: Time.now.to_i,
            user_id: user.id,
            email: user.email
          )
        rescue Intercom::IntercomError => e
          puts e
        end
        nb_events_trial_J_3 += 1
        report << "MEMBER ON TRIAL J-3 | event intercom | #{user.id} | #{user.email}"
      end
    end

    report << "-----------------------------------------" if @user_trial_J_3.present?
    report << "Nb users on trial J-3 | #{@user_trial_J_3.size}"
    report << "Nb events for trial J-3 | #{nb_events_trial_J_3}"
    report << "-----------------------------------------"


    # Traitment members on trial at J-0
    report << "MEMBER ON TRIAL J-0"
    report << "-----------------------------------------"

    @user_trial_J_0 = User.member_on_trial_should_payin(0)
    nb_payin_trial_OK = 0
    nb_payin_trial_KO = 0
    nb_events_trial_J_0 = 0

    @user_trial_J_0.each do |user|
      if user.card_id.present?
        if monthly_payin(user)
          # Change subscription: Trial is done !
          user.update(subscription: "M")
          nb_payin_trial_OK += 1
          report << "MEMBER ON TRIAL J-0 | subscription OK | #{user.id} | #{user.email}"
        else
          user.update(member: false)
          nb_payin_trial_KO += 1
          report << "MEMBER ON TRIAL J-0 | subscription KO + member inactivate | #{user.id} | #{user.email}"
        end
      else
        user.update(member: false)
        begin
          intercom.events.create(
            event_name: "TRIAL-J-0",
            created_at: Time.now.to_i,
            user_id: user.id,
            email: user.email
          )
        rescue Intercom::IntercomError => e
          puts e
        end
        nb_events_trial_J_0 += 1
        report << "MEMBER ON TRIAL J-0 | event intercom + member inactivate | #{user.id} | #{user.email}"
      end
    end

    report << "-----------------------------------------" if @user_trial_J_0.present?
    report << "Nb users on trial J-0 | #{@user_trial_J_0.size}"
    report << "Nb payin OK trial J-0 | #{nb_payin_trial_OK}"
    report << "Nb payin KO trial J-0 | #{nb_payin_trial_KO}"
    report << "Nb events for trial J-0 | #{nb_events_trial_J_0}"
    report << "-----------------------------------------"


    # Traitment members should PAYIN
    report << "MONTHLY MEMBER J-0"
    report << "-----------------------------------------"

    @user_member_should_payin = User.member_should_payin(0)
    nb_member_payin_OK = 0
    nb_member_payin_KO = 0


    # if last day of month and previous month is longer
    if Time.now.end_of_day == Time.now.end_of_month && Time.now.prev_month.day > Time.now.end_of_month.day
      index = Time.now.end_of_month.day - Time.now.prev_month.day

      (1..index).each do |i|
        @user_member_should_payin << User.member_should_payin(-i)
      end

      @user_member_should_payin = @user_member_should_payin.reject(&:empty?)
    end

    @user_member_should_payin.each do |user|
      if monthly_payin(user)
        nb_member_payin_OK += 1
        report << "MONTHLY MEMBER | payin OK | #{user.id} | #{user.email}"
      else
        nb_member_payin_KO += 1
        report << "MONTHLY MEMBER | payin KO | #{user.id} | #{user.email}"
      end
    end

    report << "-----------------------------------------" if @user_member_should_payin.present?
    report << "Nb members should payin | #{@user_member_should_payin.size}"
    report << "Nb payin OK J-0 | #{nb_member_payin_OK}"
    report << "Nb payin KO J-0 | #{nb_member_payin_KO}"
    report << "-----------------------------------------"


    # Traitment members should have PAYIN J+7
    report << "MONTHLY MEMBER J+7"
    report << "-----------------------------------------"

    @user_member_should_payin_J_7 = User.member_should_payin(7)
    nb_events_member_J_7 = 0

    # if last day of month and previous month is longer
    if Time.now.end_of_day == Time.now.end_of_month && Time.now.prev_month.day > Time.now.end_of_month.day
      index = Time.now.end_of_month.day - Time.now.prev_month.day

      (1..index).each do |i|
        @user_member_should_payin_J_7 << User.member_should_payin_J_7(7-i)
      end

      @user_member_should_payin_J_7 = @user_member_should_payin_J_7.reject(&:empty?)
    end

    @user_member_should_payin_J_7.each do |user|
      user.update_attribute('member', false)
      begin
        intercom.events.create(
          event_name: "MEMBER-J+7",
          created_at: Time.now.to_i,
          user_id: user.id,
          email: user.email
        )
      rescue Intercom::IntercomError => e
        puts e
      end
      nb_events_member_J_7 += 1
      report << "MONTHLY MEMBER J+7 | event intercom + member inactivate | #{user.id} | #{user.email}"
    end

    report << "-----------------------------------------" if @user_member_should_payin_J_7.present?
    report << "Nb members should payin J+7 | #{@user_member_should_payin_J_7.size}"
    report << "Nb events for payin J+7 | #{nb_events_member_J_7}"
    report << "-----------------------------------------"


    # Report : Edit + Send to slack
    puts "-----------------------------------------"
    puts "Report MONTHLY PAYIN JOB"
    puts "-----------------------------------------"
    puts ""

    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
    attachment = {
      fallback: "Report MONTHLY PAYIN JOB",
      fields: fields,
      color: "good"
    }
    notifier.ping "Report MONTHLY PAYIN JOB", attachments: [attachment]


  end

  private

  def monthly_payin(user)
    wallet_id = Cause.find_by_id(user.cause_id).wallet_id if user.cause_id
    wallet_id = ENV['MANGOPAY_CFORGOOD_WALLET_ID'] unless wallet_id

    result = MangopayServices.new(user).create_mangopay_payin(wallet_id)

    if result["ResultMessage"] != "Success"
      message = "#{user.id} | #{user.email} | *erreur lors du paiement* | #{result['ResultCode']} | #{result['ResultMessage']}"
      # Message on slack
      if Rails.env.production?
        notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_USER_URL']
        notifier.ping message
      else
        puts message
      end
    end

    @payment = user.payments.new(cause_id: user.cause_id, amount: user.amount, subscription: user.subscription, done: result["ResultMessage"] == "Success" ? true : false)
    @payment.save

    if @payment.done
      user.update(date_last_payment: Time.now, code_partner: nil, date_end_partner: nil)
      return true
    else
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
      begin
        intercom.events.create(
          event_name: "ERROR-PAYMENT",
          created_at: Time.now.to_i,
          user_id: user.id,
          email: user.email
        )
      rescue Intercom::IntercomError => e
      end
      return false
    end
  end

end
