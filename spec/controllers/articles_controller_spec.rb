require 'rails_helper'

RSpec.describe ArticlesController do
  
  describe "GET index" do
    
    let(:article) { Article.create(title: 'title title', body: 'body body') }
    
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

    let!(:article) { Article.create(title: 'title title', body: 'body body') }

    before do
      get :show, params: {id: article}
    end

    it 'should response status 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns @article' do
      expect(assigns(:article)).to eq(article)
    end

    it 'render template show' do
      expect(response).to render_template(:show)
    end

  end

end