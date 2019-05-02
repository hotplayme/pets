require 'rails_helper'

RSpec.describe ArticleImage, type: :model do
  
  it { should validate_presence_of :file }
  it { should belong_to :article }

  describe '#upload' do
    
    let(:article) { create :article }
    let!(:article_image) { create :article_image }

    context "Validate" do
      it "Good File" do
        file = 'spec/tmp/image.jpg' 
        expect(ArticleImage.validate_image(file)).to eq true
      end

      it "Bad File" do
        file = 'spec/tmp/test.txt'
        expect(ArticleImage.validate_image(file)).to eq false
      end
    end

    context 'Upload file' do
      it '#upload' do
        file = fixture_file_upload('spec/tmp/image.jpg')
        article_image.upload(file)
        expect(File.exists?(Rails.root.join('public', 'files', 'articles', article_image.article.id.to_s, "#{article_image.file}.jpg"))).to eq true
      end
    end
    
  end

end