class Admin::ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def show
    if @article = Article.find_by_id(params[:id])
      @images = @article.article_images
    else
      redirect_to admin_articles_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      if params[:article][:article_image].present?
        params[:article][:article_image].each do |image|
          article_image = @article.article_images.create(file: (0...8).map { (65 + rand(26)).chr }.join.downcase)
          article_image.upload(image)
        end
      end
      redirect_to admin_article_path(@article)
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admin_article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

end
