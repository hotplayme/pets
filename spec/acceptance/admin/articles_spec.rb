require_relative '../acceptance_helper'

feature 'Article' do
  let(:user) { create(:user) }
  
  before do
    sign_in(user)
  end

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
    fill_in 'article_preview_text',  with: 'New Article Preview'
    fill_in 'article_slug',  with: 'New Article Slug'
    click_button 'Add'

    expect(page).to have_current_path(admin_article_path(Article.last))
    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_text('New Article Preview')
    expect(page).to have_text('New Article Slug')
    expect(page).to have_link('Edit')
  end

  scenario 'user create article with image' do
    visit '/admin/articles'
    click_on 'Add'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    fill_in 'article_preview_text',  with: 'New Article Preview'
    fill_in 'article_slug',  with: 'New Article Slug'
    attach_file 'article_image', 'spec/tmp/image.jpg'
    click_button 'Add'

    expect(page).to have_current_path(admin_article_path(Article.last))
    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_text('New Article Preview')
    expect(page).to have_text('New Article Slug')
    expect(page).to have_css("img[src*='#{Article.last.main_thumb}']")
    expect(page).to have_link('Edit')
  end

  scenario 'user edit article' do
    article = create(:article)
    visit '/admin/articles'
    click_on 'Edit'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    fill_in 'article_preview_text',  with: 'New Article Preview'
    fill_in 'article_slug',  with: 'New Article Slug'
    click_on 'Save'

    expect(page).to have_text('New Article Title')
    expect(page).to have_text('New Article Body')
    expect(page).to have_text('New Article Preview')
    expect(page).to have_text('New Article Slug')
    expect(page).to have_current_path(admin_article_path(article))
  end

  scenario 'user delete article with images' do
    visit '/admin/articles'
    click_on 'Add'

    fill_in 'article_title', with: 'New Article Title'
    fill_in 'article_body',  with: 'New Article Body'
    fill_in 'article_preview_text',  with: 'New Article Preview'
    fill_in 'article_slug',  with: 'New Article Slug'
    attach_file 'article_image', 'spec/tmp/image.jpg'
    click_button 'Add'
    visit edit_admin_article_path(Article.last)
    click_on 'Delete'

    expect(page).to have_current_path(admin_articles_path)
    expect(page).to_not have_text('New Article Title')

  end

end