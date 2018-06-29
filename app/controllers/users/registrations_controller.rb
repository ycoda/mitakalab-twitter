class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in_and_redirect @user, :event => :authentication
    else
      render new_user_registration_path
    end
  end

  def build_resource(hash=nil)
    if hash != nil
      hash[:uid] = User.create_unique_string
      super
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
