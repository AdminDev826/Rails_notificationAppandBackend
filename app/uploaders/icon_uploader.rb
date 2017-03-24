class IconUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process eager: true # Force version generation at upload time
  # process convert: 'jpg'

  cloudinary_transformation :transformation => [{:width => 2000, :height => 2000, :crop => :limit, :folder => Rails.env}]

  version :thumb do |variable|
    cloudinary_transformation :width => 100, :height => 100, :crop => :fill, :dpr => 2.0
  end
end
