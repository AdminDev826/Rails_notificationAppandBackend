namespace :payment do

  desc "Control monthly payment"
  task monthly_payin: :environment do
    puts "----------------------------------------"
    puts "TASK MONTHLY_PAYIN STARTING"
    puts "----------------------------------------"

    MonthlyPayinJob.perform_later

    puts "----------------------------------------"
    puts "TASK MONTHLY_PAYIN DONE"
    puts "----------------------------------------"
  end

end
