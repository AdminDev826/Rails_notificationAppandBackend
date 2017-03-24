namespace :user do

  desc "Update"
  task update_zipcode: :environment do
    puts "----------------------------------------"
    puts "TASK UPDATE_ZIPCODE STARTING"
    puts "----------------------------------------"

    UpdateZipcode.perform_later

    puts "----------------------------------------"
    puts "TASK UPDATE_ZIPCODE DONE"
    puts "----------------------------------------"
  end

end
