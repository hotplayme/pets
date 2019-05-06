class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :path
      t.string :file
      t.integer :article_id, index: true
      t.integer :bytes
      t.timestamps
    end
  end
end
