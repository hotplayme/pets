class AddMainThumbIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :main_thumb_id, :integer, index: true
  end
end
