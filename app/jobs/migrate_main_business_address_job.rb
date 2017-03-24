class MigrateMainBusinessAddressJob < ApplicationJob

  queue_as :default

  def perform

    report = []
    report << "-----------------------------------------"

    nb_businesses = 0
    nb_addresses_create_ok = 0
    nb_addresses_create_ko = 0
    nb_addresses = 0
    nb_timetables_create_ok = 0
    nb_timetables_create_ko = 0

    Business.all.each do |business|
      if !business.addresses.main.present?
        nb_businesses += 1
        @address = business.addresses.build(name: "Adresse principale",
                                            street: business.street || nil,
                                            city: business.city || nil,
                                            zipcode: business.zipcode || nil,
                                            active: true,
                                            main: true)
        if @address.save
          nb_addresses_create_ok += 1
        else
          nb_addresses_create_ko += 1
          report << "ERROR build address | business : #{business.id} | street : #{business.street} | zipcode : #{business.zipcode} | city : #{business.city} |"
        end
      end
    end

    Address.where("start_time is not null or end_time is not null").each do |address|
      nb_addresses += 1
      @timetable = address.timetables.build(day: address.day || nil,
                                            start_at: address.start_time || nil,
                                            end_at: address.end_time || nil)
      if @timetable.save
        nb_timetables_create_ok += 1
      else
        nb_timetables_create_ko += 1
        report << "ERROR build timetable | address | #{address.id}"
      end
    end

    report << "Nb businesses read | #{nb_businesses}"
    report << "Nb addresses create OK | #{nb_addresses_create_ok}"
    report << "Nb addresses create KO| #{nb_addresses_create_ko}"
    report << "-----------------------------------------"
    report << "Nb addresses read | #{nb_addresses}"
    report << "Nb timetables create OK | #{nb_timetables_create_ok}"
    report << "Nb timetables create KO | #{nb_timetables_create_ko}"
    report << "-----------------------------------------"

    # Edit report + Send to slack
    puts "-----------------------------------------"
    puts "Report MIGRATE ADDRESSES AND TIMETABLES JOB"
    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    if Rails.env.production?
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
      attachment = {
        fallback: "Report MIGRATE ADDRESSES AND TIMETABLES JOB",
        fields: fields,
        color: "good"
      }
      notifier.ping "Report MIGRATE ADDRESSES AND TIMETABLES JOB", attachments: [attachment]
    end

  end
end
