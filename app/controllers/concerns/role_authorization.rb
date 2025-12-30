module RoleAuthorization
  extend ActiveSupport::Concern

  private

  def authorize_admin!
    unless current_user.nil? || current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_picker!
    unless current_user.nil? || current_user&.picker_access?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_packer!
    unless current_user.nil? || current_user&.packer_access?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_user!
    unless current_user
      redirect_to root_path
    end
  end
end
