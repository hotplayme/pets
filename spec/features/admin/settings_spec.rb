require 'rails_helper'

RSpec.feature 'Settings', type: feature do
  scenario 'index page, see form' do
    visit admin_settings_path

    expect(page).to have_selector("input[name='setting[image_sizes]']")
  end

  scenario 'edit settings' do 
    visit admin_settings_path
    fill_in 'setting_image_sizes', with: "200x300,400x500,600x700"
    click_button 'Update'
    expect(page).to have_current_path(admin_settings_path)
    expect(page).to have_selector("input[value='200x300,400x500,600x700']")
  end
end