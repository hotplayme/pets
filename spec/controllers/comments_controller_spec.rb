require 'rails_helper'

RSpec.describe CommentsController do
  
  describe 'POST #create' do
    let!(:article) { create(:article) }

    context 'validate good' do
      it 'should save comment in db' do
        expect { post :create, params: { article_id: article, comment: attributes_for(:comment) } }.to change(article.comments, :count).by(1)
      end

      it 'should redirect to article path' do
        post :create, params: { article_id: article, comment: attributes_for(:comment) }
        expect(response).to redirect_to article_path(article, article.slug)
      end
    end

  end
end