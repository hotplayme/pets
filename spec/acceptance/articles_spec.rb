require_relative 'acceptance_helper'

feature 'Articles' do
  let!(:article) { create(:article) }
  it 'visit article show page' do
    visit root_path
    click_on 'Дальше'

    expect(page).to have_current_path(article_path(article, article.slug))
    expect(page).to have_text(article.body)
  end

end