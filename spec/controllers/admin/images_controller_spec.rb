require 'rails_helper'

RSpec.describe Admin::ImagesController do
  let!(:article) { create(:article) }
  let!(:image) { article.images.create }
  describe 'DELETE #destroy' do
    
  end
end