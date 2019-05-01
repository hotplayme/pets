class Article < ApplicationRecord
  validates_presence_of :title, :body
  validates_length_of [:title, :body], minimum: 5
end
