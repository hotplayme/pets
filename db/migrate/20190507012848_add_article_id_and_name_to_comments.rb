class AddArticleIdAndNameToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :article_id, :integer, index: true
    add_column :comments, :name, :string
  end
end
