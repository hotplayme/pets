class ChangeDefaultForSettingsImageSizes < ActiveRecord::Migration[5.2]
  def change
    change_column :settings, :image_sizes, :string, default: '200x100,300x200'
  end
end
