class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? #deviseで生成したファイルのみに適用する

  def after_sign_in_path_for(resource)
    tweets_path if resource.kind_of?(User)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
