require 'rails_helper'

RSpec.feature 'Articles', type: feature do

  scenario "index page, User see all articles" do
    article = create(:article)
    visit '/admin/articles'

    expect(page).to have_text("Articles")
    expect(page).to have_link("Add")
    expect(page).to have_link("Article Title")
  end

  scenario 'user create new article' do
    visit '/admin/articles'
    click_on 'Add'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    click_button 'Add'

    expect(page).to have_current_path(admin_article_path(Article.last))
    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_link('Edit')
  end

  scenario 'user create article with image' do
    visit '/admin/articles'
    click_on 'Add'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    attach_file 'article_article_image', 'spec/tmp/image.jpg'
    click_button 'Add'

    expect(page).to have_current_path(admin_article_path(Article.last))
    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_css("img[src*='#{Article.last.article_images.last.file}.jpg']")
    expect(page).to have_link('Edit')
  end

  scenario 'user edit article' do
    article = create(:article)
    visit '/admin/articles'
    click_on 'Article Title'
    click_on 'Edit'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    click_on 'Save'

    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_current_path(admin_article_path(article))
  end

end