class Article < ApplicationRecord
  validates_presence_of :title, :body
  validates_length_of [:title, :body], minimum: 5
  
  has_many :images

  def main_thumb
    return '/files/zaglushka.jpg' if self.images.count == 0
    if self.main_thumb_id
      image = Image.find_by_id(self.main_thumb_id)
      return image.path + image.file + '.jpg'
    else
      return '/files/zaglushka.jpg'
    end
  end
end
