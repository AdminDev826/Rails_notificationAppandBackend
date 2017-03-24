namespace :perk do

  desc "Control flash in time"
  task daily_control_flash: :environment do
    puts "----------------------------------------"
    puts "TASK PERK_IN_TIME STARTING"
    puts "----------------------------------------"

    DailyControlFlashJob.perform_later

    puts "----------------------------------------"
    puts "TASK PERK_IN_TIME DONE"
    puts "----------------------------------------"
  end

  desc "Extract perk datas"
  task extract_perks_job: :environment do
    puts "----------------------------------------"
    puts "TASK EXTRACT_PERKS STARTING"
    puts "----------------------------------------"

    ExtractPerksJob.perform_later

    puts "----------------------------------------"
    puts "TASK EXTRACT_PERKS DONE"
    puts "----------------------------------------"
  end

end
