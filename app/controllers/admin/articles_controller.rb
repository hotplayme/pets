class Admin::ArticlesController < AdminController
  
  def index
    @articles = Article.order("id DESC")
  end

  def show
    if @article = Article.find_by_id(params[:id])
      @images = @article.images
    else
      redirect_to admin_articles_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.id = Article.last.id + rand(10..20) if Article.last
    
    if @article.save
      if params[:article][:image].present?
        params[:article][:image].each do |file|
          rnd = (0...8).map { (65 + rand(26)).chr }.join.downcase
          path = '/files/articles/'+@article.id.to_s+'/'
          # bytes = File.size(file.tempfile)
          image = @article.images.create(file: rnd+'.jpg', path: path)
          image.upload(file)
          image.create_sizes
        end
      end
      if @article.images.count > 0
        @article.update(main_thumb_id: @article.images.sample.id)
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
    require 'fileutils'
    @article = Article.find(params[:id])
    @article.images.destroy_all
    FileUtils.rm_rf(Rails.root.to_s+'/public/files/articles/'+@article.id.to_s)
    @article.destroy
    redirect_to admin_articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :preview_text, :slug)
  end

end
