FactoryBot.define do
  
  factory :article do
    title { "Article Title" }
    body  { "Article Body" }
  end

  factory :bad_validate_article, class: Article do
    title {"Tit"}
    body {"Body"}
  end

end