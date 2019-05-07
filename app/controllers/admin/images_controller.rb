class Admin::ImagesController < ApplicationController
  def destroy
    @image = Image.find(params[:id])
    @article = @image.article
    File.delete("#{Rails.root}/public/files/articles/#{@article.id}/#{@image.file}") if File.exists?("#{Rails.root}/public/files/articles/#{@article.id}/#{@image.file}")
    Setting.first_or_create.image_sizes.split(',').each do |size|
      File.delete("#{Rails.root}/public/files/articles/#{@article.id}/#{size}/#{@image.file}") if File.exists?("#{Rails.root}/public/files/articles/#{@article.id}/#{size}/#{@image.file}")
    end
    @image.destroy
    redirect_to edit_admin_article_path(@article)
  end

  def set_main
    article = Article.find(params[:article])
    article.update(main_thumb_id: params[:image_id])
    redirect_to edit_admin_article_path(article)
  end
end
