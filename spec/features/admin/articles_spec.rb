require 'rails_helper'

RSpec.feature 'Articles', type: feature do
  scenario "index page, User see all articles" do
    visit '/admin/articles'

    expect(page).to have_text("Articles")
  end
end