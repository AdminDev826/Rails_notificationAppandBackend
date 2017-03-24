class DailyControlFlashJob < ApplicationJob
  queue_as :default

  def perform

    report = []
    report << "-----------------------------------------"

    # Select all flash perks not in time
    @perks = Perk.active.where('flash = ? and end_date < ?', true, Time.now)

    report << "Nb perks read | #{@perks.size}"
    report << "-----------------------------------------"

    nb_perk_inactivated = 0

    # Inactive all selected perks
    @perks.each do |perk|
      if perk.update(active: false)
        nb_perk_inactivated += 1
        report << "Perk | #{perk.id} | Business | #{perk.business_id} | #{perk.business.name} | inactive"
      end
    end

    report << "-----------------------------------------" if @perks.present?
    report << "Nb perks updated | #{nb_perk_inactivated}"
    report << "-----------------------------------------"

    # Edit report + Send to slack
    puts "-----------------------------------------"
    puts "Report DAILY CONTROL FLASH JOB"
    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
    attachment = {
      fallback: "Report DAILY CONTROL FLASH JOB",
      fields: fields,
      color: "good"
    }
    notifier.ping "Report DAILY CONTROL FLASH JOB", attachments: [attachment]

  end
end
