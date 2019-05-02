FactoryBot.define do
  factory :article_image do
    file { (0...8).map { (65 + rand(26)).chr }.join.downcase }
    article
  end

  factory :comment do
    
  end

  
  factory :article do
    title { "Article Title" }
    body  { "Article Body" }
  end

  factory :bad_validate_article, class: Article do
    title {"Tit"}
    body {"Body"}
  end

end