FactoryBot.define do
  factory :user do
    email { 'test@admin.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end

  factory :setting do
    image_sizes { '240x180,300x200'}
  end

  factory :image do
    file { (0...8).map { (65 + rand(26)).chr }.join.downcase + '.jpg' }
    article
  end

  factory :comment do
    name { 'commenter' }
    body { 'comment body' }
  end
  
  factory :article do
    title { "Article Title" }
    body  { "Article Body" }
    preview_text {"Article Preview"}
    slug { "slug-slug" }
  end

  factory :bad_validate_article, class: Article do
    title {"Tit"}
    body {"Body"}
    preview_text {"Pre"}
    slug { "это" }
  end
end