require 'rails_helper'

RSpec.describe Admin::SettingsController do

  describe 'GET #index' do
    it 'should return status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'should assigns @setting' do
      get :index
      expect(assigns(:setting)).to eq(Setting.last)
    end

    it 'should render index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'PATCH #update' do
    
  end

end