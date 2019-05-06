class ImageSizesToString < ActiveRecord::Migration[5.2]
  def change
    change_column :settings, :image_sizes, :string, default: ''
  end
end
