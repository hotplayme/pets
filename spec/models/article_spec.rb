require 'rails_helper'

RSpec.describe 'Article', type: :model do

  context 'Validation' do

    it 'should presense of title' do
      Article.create(body: 'Body')
      expect(Article.count).to eq(0)
    end

    it 'should presense of body' do
      Article.create(title: 'title')
      expect(Article.count).to eq(0)
    end

    it "minimum title 5 digits" do
      Article.create(title: 'tit', body: 'Body Body Body')
      expect(Article.count).to eq(0)
    end

    it "minimum body 5 digits" do
      Article.create(title: 'Title Title', body: 'Body')
      expect(Article.count).to eq(0)
    end

  end

end