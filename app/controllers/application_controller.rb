class ApplicationController < ActionController::Base
  include RoleAuthorization
  include Pagy::Method

  before_action :authorize_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def apply_pagy(scope)
    @pagy, new_scope = pagy(:offset, scope, limit: params[:view_all] == "1" ? 1_000_000 : Pagy.options[:limit])
    new_scope
  end
end
