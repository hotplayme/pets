require 'rails_helper'

RSpec.describe HomeController do

  describe 'GET #index' do
    let (:article) { Article.create(title: 'title title', body: 'body body') }
    before do
      get :index
    end
    
    it 'should response code 200' do
      expect(response.status).to eq(200)
    end

    it 'should @assigns articles' do
      expect(assigns(:articles)).to eq([article])
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end

  end

end