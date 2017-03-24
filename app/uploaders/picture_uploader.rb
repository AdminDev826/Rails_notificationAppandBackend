class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process eager: true # Force version generation at upload time
  process convert: 'jpg'

  cloudinary_transformation :transformation => [{:width => 2000, :height => 2000, :crop => :limit, :folder => Rails.env}]

  version :medium do |variable|
    cloudinary_transformation :width => 800, :height => 600, :crop => :fill, :dpr => 2.0
  end

  version :card do |variable|
    cloudinary_transformation :width => 450, :height => 350, :crop => :fill, :dpr => 2.0
  end

  version :thumb do |variable|
    cloudinary_transformation :width => 100, :height => 100, :crop => :fill, :dpr => 2.0
  end

  version :avatar do |variable|
    cloudinary_transformation :width => 100, :height => 100, :crop => :thumb, :gravity => :face, :dpr => 2.0
  end

end
