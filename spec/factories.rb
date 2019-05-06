FactoryBot.define do
  factory :setting do
    image_sizes { '240x180,300x200'}
  end

  factory :image do
    file { (0...8).map { (65 + rand(26)).chr }.join.downcase }
    article
  end

  factory :comment do
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