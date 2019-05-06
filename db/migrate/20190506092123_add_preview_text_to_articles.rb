class AddPreviewTextToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :preview_text, :text
  end
end
