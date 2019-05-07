require 'rails_helper'

RSpec.describe ArticlesController do
  
  describe "GET index" do
    
    let(:article) { create(:article) }
    
    before do
      get :index
    end

    it 'should page response status 200' do
      expect(response.status).to eq(200)
    end
    
    it 'assigns @articles' do
      expect(assigns(:articles)).to eq([article])
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end

  end

  describe "GET show" do

    let!(:article) { create(:article) }

    before do
      get :show, params: {id: article, slug: article.slug}
    end

    it 'should response status 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns @article' do
      expect(assigns(:article)).to eq(article)
    end

    it 'assigns @related' do
      expect(assigns(:related)).to eq([article])
    end

    it 'render template show' do
      expect(response).to render_template(:show)
    end

  end

end