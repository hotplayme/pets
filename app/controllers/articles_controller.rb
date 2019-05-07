class ArticlesController < ApplicationController

  def index
    @articles = Article.order('id desc')
  end

  def show
    @article = Article.find(params[:id])
    @related = Article.order("random()").limit(3)
  end

end
