require_relative 'acceptance_helper'

feature 'Comments' do
  
  let(:article) { create(:article) }
  
  it 'create comment' do
    visit article_path(article, article.slug)

    fill_in 'comment[name]', with: 'Alex Ivanov'
    fill_in 'comment[body]', with: 'Alex Comment Body'
    click_on 'Добавить'

    expect(page).to have_current_path(article_path(article, article.slug))
    expect(page).to have_text('Alex Ivanov')
    expect(page).to have_text('Alex Comment Body')
  end

end