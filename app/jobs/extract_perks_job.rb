class ExtractPerksJob < ApplicationJob

  require 'csv'
  require 'net/ftp'
  queue_as :default

  def perform(date, separator_char)

    separator =  separator_char || "|"
    date_from =  date || Time.now - 1.month

    path = "tmp/"
    filename = 'perk_' + Time.now.strftime("%Y%m%d_%H%M%S") + '.csv'

    report = []
    report << "-----------------------------------------"

    nb_read = 0
    perks = []

    CSV.open(path + filename, "wb", :col_sep => '|') do |csv|
      csv << ["id",
              "name",
              "business_id",
              "business_name",
              "views"]

      Perk.includes(:business).active.where("perks.updated_at > ?", date_from).each do |perk|
        nb_read += 1
        csv << [perk.id,
               perk.name,
               perk.business_id,
               perk.business.name,
               perk.nb_views]
      end
    end

    # Write file on FTP

    begin
      ftp = Net::FTP.new('ftp.cluster007.hosting.ovh.net')
      ftp.login("cforgoodny", "Bethechange85")
      ftp.chdir("datas/perk")
      ftp.passive = true
      ftp.puttextfile(path + filename, filename)
      ftp.close
    rescue Exception => e
      report << "ERROR FTP | #{e} |"
    end

    report << "Nb perks read | #{nb_read}"
    report << "-----------------------------------------"

    # Edit report + Send to slack
    puts "-----------------------------------------"
    puts "Report EXTRACT PERKS JOB"
    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    if Rails.env.production?
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
      attachment = {
        fallback: "Report EXTRACT PERKS JOB",
        fields: fields,
        color: "good"
      }
      notifier.ping "Report EXTRACT PERKS JOB", attachments: [attachment]
    end

  end
end


