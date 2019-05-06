require 'rails_helper'

RSpec.describe Admin::ArticlesController do

  describe 'GET #index' do
    let(:article) { create(:article) }
    before do
      get :index
    end

    it 'should return status 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns @articles' do
      expect(assigns(:articles)).to eq([article])
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let!(:article) { create(:article) }
    let(:article_image) { create(:article_image) }

    before do
      get :show, params: {id: article}
    end

    it 'should assigns @article' do
      expect(assigns(:article)).to eq(article)
    end

    it 'should assigns @images' do
      expect(assigns(:images)).to eq (article.images)
    end

    it 'should render show template' do
      expect(response).to render_template(:show)
    end

    it 'should redirect to articles path, if ID not exists' do
      get :show, params: { id: article.id+1 }
      expect(response).to redirect_to admin_articles_path
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end
    it 'should assigns @article' do
      expect(assigns(:article)).to be_a_new(Article)
    end

    it 'should render template new' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'Validate Good' do
      it 'should save article in db' do
        expect { post :create, params: { article: attributes_for(:article) } }.to change(Article, :count).by(1)
      end

      it 'should redirect to show path' do
        post :create, params: { article: attributes_for(:article) }
        expect(response).to redirect_to admin_article_path(assigns(:article))
      end

      it 'create article with image' do
        uploaded_file = fixture_file_upload("#{Rails.root}/spec/tmp/image.jpg", 'image/jpeg')
        uploaded_file2 = fixture_file_upload("#{Rails.root}/spec/tmp/image.jpg", 'image/jpeg')

        post :create, params: { article: attributes_for(:article).merge(image:  [uploaded_file, uploaded_file2] ) }
        expect(response).to redirect_to admin_article_path(assigns(:article))
        expect(File.exist?("#{Rails.root}/public/files/articles/#{Article.last.id}/#{Article.last.images.last.file}")).to be true
        Setting.last.image_sizes.split(',').each do |size|
          expect(File.exist?("#{Rails.root}/public/files/articles/#{Article.last.id}/#{size}/#{Article.last.images.last.file}")).to be true
        end
      end
    end

    context 'Validate Not Good' do
      it 'should not save article in db' do
        expect { post :create, params: { article: attributes_for(:bad_validate_article) } }.to_not change(Article, :count)
      end

      it 'should render template new' do
        post :create, params: { article: attributes_for(:bad_validate_article) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:article) { create(:article) }
    before do
      get :edit, params: {id: article}
    end
    it 'should assigns @article' do
      expect(assigns(:article)).to eq(article)
    end

    it 'should render edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:article) { create(:article) }

    context 'Validate True' do
      before do
        patch :update, params: { id: article, article: { title: 'new title', body: 'new body' } }
      end

      it 'assign @article' do  
        expect(assigns(:article)).to eq(article)
      end
      
      it 'should change object in db and redirect to show template' do
        article.reload
        expect(article.title).to eq('new title')
        expect(article.body).to  eq('new body')
        expect(response).to redirect_to admin_article_path(article)
      end
    end

    context 'Validate False' do
      before do
        patch :update, params: { id: article, article: {title: 'new', body: 'new'} }
      end

      it 'should NOT change object in db' do  
          expect(article.title).to eq('Article Title')
          expect(article.body).to eq('Article Body')
      end
      
      it 'should render edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { create(:article) }
    
    it 'assign @article' do
      delete :destroy, params: { id: article }
      expect(assigns(:article)).to eq(article)
    end

    it 'delete @article from db' do
      expect { delete :destroy, params: { id: article } }.to change(Article, :count).by(-1)
    end

    it 'redirect to articles path' do
      delete :destroy, params: { id: article }
      expect(response).to redirect_to admin_articles_path
    end

    it 'delete article with images' do
      uploaded_file = fixture_file_upload("#{Rails.root}/spec/tmp/image.jpg", 'image/jpeg')
      uploaded_file2 = fixture_file_upload("#{Rails.root}/spec/tmp/image.jpg", 'image/jpeg')
      post :create, params: { article: (attributes_for(:article).merge(image:  [uploaded_file, uploaded_file2]))   }
      expect { delete :destroy, params: { id: Article.last } }.to change(Article, :count).by(-1).and change(Image, :count).by(-2)
      expect(File.exist?("#{Rails.root}/public/files/articles/#{Article.last.id}")).to_not eq true

    end
  end

end