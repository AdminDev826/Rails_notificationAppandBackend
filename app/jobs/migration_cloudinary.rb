class MigrationCloudinaryJob < ApplicationJob
  queue_as :default

  def perform

    puts "-----------------------------------------"
    puts "MIGRATION FROM S3 TO CLOUDINARY"
    puts "-----------------------------------------"

    errors = []

    User.update_all(picture: nil)
    user_picture = 0
    User.where('s3_picture_file_name IS NOT NULL').each do |user|
      url = user.s3_picture.url.gsub("users/s3_", "users/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        user.picture = result[1]
        if user.save
          user_picture += 1
        end
      rescue Exception => e
        errors << "#{user.id}|User|picture|#{url}|#{e}"
      end
    end

    Business.update_all(picture: nil)
    business_picture = 0
    Business.where('s3_picture_file_name IS NOT NULL').each do |business|
      url = business.s3_picture.url.gsub("businesses/s3_", "businesses/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        business.picture = result[1]
        if business.save
          business_picture += 1
        end
      rescue Exception => e
        errors << "#{business.id}|Business|picture|#{url}|#{e}"
      end
    end

    Business.update_all(leader_picture: nil)
    business_leader_picture = 0
    Business.where('s3_leader_picture_file_name IS NOT NULL').each do |business|
      url = business.s3_leader_picture.url.gsub("businesses/s3_", "businesses/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        business.leader_picture = result[1]
        if business.save
          business_leader_picture += 1
        end
      rescue Exception => e
        errors << "#{business.id}|Business|leader_picture|#{url}|#{e}"
      end
    end

    Business.update_all(logo: nil)
    business_logo = 0
    Business.where('s3_logo_file_name IS NOT NULL').each do |business|
      url = business.s3_logo.url.gsub("businesses/s3_", "businesses/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        business.logo = result[1]
        if business.save
          business_logo += 1
        end
      rescue Exception => e
        errors << "#{business.id}|Business|logo|#{url}|#{e}"
      end
    end

    BusinessCategory.update_all(picture: nil)
    business_category_picture = 0
    BusinessCategory.where('s3_picture_file_name IS NOT NULL').each do |business_category|
      url = business_category.s3_picture.url.gsub("business_categories/s3_", "business_categories/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        business_category.picture = result[1]
        if business_category.save
          business_category_picture += 1
        end
      rescue Exception => e
        errors << "#{business_category.id}|BusinessCategory|picture|#{url}|#{e}"
      end
     end

    Cause.update_all(picture: nil)
    cause_picture = 0
    Cause.where('s3_picture_file_name IS NOT NULL').each do |cause|
      url = cause.s3_picture.url.gsub("causes/s3_", "causes/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        cause.picture = result[1]
        if cause.save
          cause_picture += 1
        end
      rescue Exception => e
        errors << "#{cause.id}|Cause|picture|#{url}|#{e}"
      end
    end

    Cause.update_all(logo: nil)
    cause_logo = 0
    Cause.where('s3_logo_file_name IS NOT NULL').each do |cause|
      url = cause.s3_logo.url.gsub("causes/s3_", "causes/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        cause.logo = result[1]
        if cause.save
          cause_logo += 1
        end
      rescue Exception => e
        errors << "#{cause.id}|Cause|logo|#{url}|#{e}"
      end
    end

    CauseCategory.update_all(picture: nil)
    cause_category_picture = 0
    CauseCategory.where('s3_picture_file_name IS NOT NULL').each do |cause_category|
      url = cause_category.s3_picture.url.gsub("cause_categories/s3_", "cause_categories/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        cause_category.picture = result[1]
        if cause_category.save
          cause_category_picture += 1
        end
      rescue Exception => e
        errors << "#{cause_category.id}|CauseCategory|picture|#{url}|#{e}"
      end
    end

    Perk.update_all(picture: nil)
    perk_picture = 0
    Perk.where('s3_picture_file_name IS NOT NULL').each do |perk|
      url = perk.s3_picture.url.gsub("perks/s3_", "perks/")
      begin
        c = Cloudinary::Uploader.upload(url, crop: :limit, width: 2000, height: 2000, folder: Rails.env)
        result = c["url"].split("http://res.cloudinary.com/dktivbech/")
        perk.picture = result[1]
        if perk.save
          perk_picture += 1
        end
      rescue Exception => e
        errors << "#{perk.id}|Perk|picture|#{url}|#{e}"
      end
    end

    puts "Nb user_picture read: #{user_picture}"
    puts "Nb user_picture uploaded: #{user_picture}"
    puts "--------------------------------------------"
    puts "Nb business_picture read: #{business_picture}"
    puts "Nb business_picture uploaded: #{business_picture}"
    puts "--------------------------------------------"
    puts "Nb business_leader_picture read: #{business_leader_picture}"
    puts "Nb business_leader_picture uploaded: #{business_leader_picture}"
    puts "--------------------------------------------"
    puts "Nb business_logo read: #{business_logo}"
    puts "Nb business_logo uploaded: #{business_logo}"
    puts "--------------------------------------------"
    puts "Nb business_category_picture read: #{business_category_picture}"
    puts "Nb business_category_picture uploaded: #{business_category_picture}"
    puts "--------------------------------------------"
    puts "Nb cause_picture read: #{cause_picture}"
    puts "Nb cause_picture uploaded: #{cause_picture}"
    puts "--------------------------------------------"
    puts "Nb cause_logo read: #{cause_logo}"
    puts "Nb cause_logo uploaded: #{cause_logo}"
    puts "--------------------------------------------"
    puts "Nb cause_category_picture read: #{cause_category_picture}"
    puts "Nb cause_category_picture uploaded: #{cause_category_picture}"
    puts "--------------------------------------------"
    puts "Nb perk_picture read: #{perk_picture}"
    puts "Nb perk_picture uploaded: #{perk_picture}"
    puts "--------------------------------------------"

    puts "Nb error: #{errors.count}"
    puts "--------------------------------------------"
    errors.each do |error|
      puts error
    end

  end
end

