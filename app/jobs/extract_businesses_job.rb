class ExtractBusinessesJob < ApplicationJob

  require 'csv'
  require 'open-uri'
  require 'net/ftp'
  queue_as :default

  def perform(date, separator_char)

    separator =  separator_char || "|"
    date_from =  date || "20000101"

    path = "tmp/"
    filename = 'business_' + Time.now.strftime("%Y%m%d_%H%M%S") + '.csv'

    report = []
    report << "-----------------------------------------"

    nb_businesses_read = 0

    businesses = []

    CSV.open(path + filename, "wb", :col_sep => '|') do |csv|
      csv << ["id",
              "name",
              "street",
              "zipcode",
              "city",
              "url",
              "telephone",
              "email",
              "description",
              "business_category_id",
              "latitude",
              "longitude",
              "facebook",
              "twitter",
              "instagram",
              "leader_first_name",
              "leader_last_name",
              "leader_description",
              "online",
              "leader_phone",
              "leader_email",
              "shop",
              "itinerant",
              "picture",
              "leader_picture",
              "logo",
              "like",
              "unlike",
              "link_video"]

      Business.active.where("businesses.updated_at > ?", date_from).includes(:main_address, :labels).each do |business|
        nb_businesses_read += 1
        row = [business.id,
               business.name,
               business.street,
               business.zipcode,
               business.city,
               business.url,
               business.telephone,
               business.email,
               business.description.present? ? business.description.squish : "",
               business.business_category_id,
               business.latitude,
               business.longitude,
               business.facebook,
               business.twitter,
               business.instagram,
               business.leader_first_name,
               business.leader_last_name,
               business.leader_description.present? ? business.leader_description.squish : "",
               business.online,
               business.leader_phone,
               business.leader_email,
               business.shop,
               business.itinerant,
               business.picture,
               business.leader_picture,
               business.logo,
               business.like,
               business.unlike,
               business.link_video]


        i = 1
        business.labels.each do |label|
          row.push(label.label_category.name)
          i += 1
        end

        (8 - i).times do
          row.push("")
        end

        address = business.main_address
        if address.present?
          row.push(address.street,
                  address.zipcode,
                  address.city,
                  address.latitude,
                  address.longitude,
                  address.name,
                  address.main)

          address.timetables.each do |timetable|
            puts timetable
            row.push(timetable.day,
                    timetable.start_at,
                    timetable.end_at)
          end

        end

        csv << row

      end
    end

    # Write file on FTP

    begin
      ftp = Net::FTP.new('ftp.cluster007.hosting.ovh.net')
      ftp.login("cforgoodny", "Bethechange85")
      ftp.chdir("datas/business")
      ftp.passive = true
      ftp.puttextfile(path + filename, filename)
      ftp.close
    rescue Exception => e
      report << "ERROR FTP | #{e} |"
    end

    report << "Nb businesses read | #{nb_businesses_read}"
    report << "-----------------------------------------"

    # Edit report + Send to slack
    puts "-----------------------------------------"
    puts "Report EXTRACT BUSINESSES JOB"
    fields = []
    report.each do |line|
      puts line
      fields << { "value": line }
    end

    if Rails.env.production?
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_JOB_URL']
      attachment = {
        fallback: "Report EXTRACT BUSINESSES JOB",
        fields: fields,
        color: "good"
      }
      notifier.ping "Report EXTRACT BUSINESSES JOB", attachments: [attachment]
    end

  end
end


