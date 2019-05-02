class CreateArticleImages < ActiveRecord::Migration[5.2]
  def change
    create_table :article_images do |t|
      t.string :file
      t.integer :article_id, index: true
      t.timestamps
    end
  end
end
