class Comment < ApplicationRecord
  validates_presence_of :body, :name
  validates_length_of [:body], minimum: 5

  belongs_to :article
end
