class AddSlugToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :slug, :text
  end
end
