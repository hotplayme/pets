require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  describe 'GET #index' do
    it 'if not logged user, redirect to user login' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

end
