class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for user
    user_path(user)
  end

  def after_sign_out_path_for user
    root_path
  end

  def layout_by_resource
    if devise_controller? &&
      resource_name == :user &&
      (action_name == 'new' || action_name == 'create')
      'static_pages'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  private

  def set_user
    @user = User.friendly.find(current_user.id)
  end
end
