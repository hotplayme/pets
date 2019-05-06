class ArticlesController < ApplicationController

  def index
    @articles = Article.order('id desc')
  end

  def show
    @article = Article.find(params[:id])
  end

end
