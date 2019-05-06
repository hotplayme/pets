require_relative 'acceptance_helper'

RSpec.feature 'Home', type: feature do
  it 'use visit root path' do
    article = create(:article)
    visit root_path

    expect(page).to have_text('Article Title')
    expect(page).to have_text('Article Preview')
  end
end