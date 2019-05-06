class Article < ApplicationRecord
  validates_presence_of :title, :body, :preview_text, :slug
  validates_length_of [:title, :body, :preview_text, :slug], minimum: 5
  
  has_many :images

  def main_thumb
    return '/files/zaglushka.jpg' if self.images.count == 0
    if self.main_thumb_id
      image = Image.find_by_id(self.main_thumb_id)
      return image.path + image.file
    else
      return '/files/zaglushka.jpg'
    end
  end
end
