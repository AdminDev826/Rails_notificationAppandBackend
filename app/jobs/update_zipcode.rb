class UpdateZipcode < ApplicationJob
  require 'csv'
  queue_as :default

  def perform

    report = []
    report << "-----------------------------------------"

    nb_update_ok = 0
    nb_update_ko = 0

    # Read CSV file
    csv_file = File.read('data/update_zipcode.csv')

    csv = CSV.parse(csv_file, headers: true, col_sep: ';' )
    csv.each do |row|
      # update user
      begin
        user = User.find(row["Id"])
      rescue ActiveRecord::RecordNotFound
        nb_update_ko += 1
        report << "ERROR | #{row["Id"]} not found"
        next
      end
      user.zipcode = row["Zipcode"]
      if user.save
        nb_update_ok += 1
      else
        nb_update_ko += 1
        report << "ERROR | #{row["Id"]} not updated"
      end
    end

    report << "Nb row CSV | #{csv.size}"
    report << "Nb update_OK | #{nb_update_ok}"
    report << "Nb update_KO | #{nb_update_ko}"
    report << "-----------------------------------------"

    # Edit report + Send to slack
    puts "-----------------------------------------"
    puts "Report UPDATE ZIPCODE JOB"
    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
    attachment = {
      fallback: "Report UPDATE ZIPCODE JOB",
      fields: fields,
      color: "good"
    }
    notifier.ping "Report UPDATE ZIPCODE JOB", attachments: [attachment]

  end
end
