namespace :business do

  desc "Extract business datas"
  task extract_businesses_job: :environment do
    puts "----------------------------------------"
    puts "TASK EXTRACT_BUSINESSES STARTING"
    puts "----------------------------------------"

    ExtractBusinessesJob.perform_later

    puts "----------------------------------------"
    puts "TASK EXTRACT_BUSINESSES DONE"
    puts "----------------------------------------"
  end

  desc "Migrate main business address"
  task migrate_main_business_address_job: :environment do
    puts "--------------------------------------------------"
    puts "TASK MIGRATE ADDRESSES AND TIMETABLES JOB STARTING"
    puts "--------------------------------------------------"

    MigrateMainBusinessAddressJob.perform_later

    puts "--------------------------------------------------"
    puts "TASK MIGRATE ADDRESSES AND TIMETABLES JOB DONE"
    puts "--------------------------------------------------"
  end

end
