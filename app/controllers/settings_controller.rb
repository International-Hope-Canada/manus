class SettingsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_setting, only: %i[edit update]

  def index
    @breadcrumbs = [ "Settings" ]
    @pagy, @settings = pagy(:offset, Setting.order(:setting_key))
  end

  def edit
    @breadcrumbs = [ "Settings", @setting.setting_key, "Edit" ]
  end

  def update
    @breadcrumbs = [ "Settings", @setting.setting_key, "Edit" ]
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to settings_path, notice: "Setting was successfully updated." }
        format.json { render :show, status: :ok, location: settings_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:setting_value)
  end

  def set_setting
    @setting = Setting.find(params[:id])
  end
end
