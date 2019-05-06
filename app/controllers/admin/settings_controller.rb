class Admin::SettingsController < AdminController
  def index
    @setting = Setting.first_or_create
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update(setting_params)
    redirect_to admin_settings_path
  end

  private
  def setting_params
    params.require(:setting).permit(:image_sizes)
  end
end
