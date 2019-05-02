class ArticleImage < ApplicationRecord
  
  validates_presence_of :file
  belongs_to :article

  def self.validate_image(file)
    require 'mime/types'
    MIME::Types.type_for(file).first.try(:media_type) == 'image'
  end

  def upload(file)
    require "fileutils"
    upload_file = Rails.root.join('public', 'files', 'articles',  self.article.id.to_s, "#{self.file}.jpg")
    FileUtils::mkdir_p File.dirname upload_file
    File.open(upload_file, 'wb') do |f|
      f.write(file.read)
    end
  end

end
