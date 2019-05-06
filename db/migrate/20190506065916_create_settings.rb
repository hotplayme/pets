class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :image_sizes, array: true, default: []
      t.timestamps
    end
  end
end
