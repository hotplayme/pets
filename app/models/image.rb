class Image < ApplicationRecord
  validates_presence_of :file
  belongs_to :article

  def self.validate_image(file)
    require 'mime/types'
    MIME::Types.type_for(file).first.try(:media_type) == 'image'
  end

  def upload(file)
    require "fileutils"
    upload_file = Rails.root.join('public', 'files', 'articles',  self.article.id.to_s, "#{self.file}")
    FileUtils::mkdir_p File.dirname upload_file
    File.open(upload_file, 'wb') do |f|
      f.write(file.read)
    end
  end

  def create_sizes
    sizes = Setting.first_or_create.image_sizes.split(',')
    sizes.each do |size|
      Dir.mkdir(Rails.root.to_s + '/public' + self.path + size) unless File.exists?(Rails.root.to_s + '/public' + self.path + size)
      system("convert #{Rails.root.to_s}/public#{self.path}#{self.file} -resize #{size}^ -gravity center -extent #{size} -quality 85 #{Rails.root.to_s}/public#{self.path}#{size}/#{self.file}")
    end
  end
end
