class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password]
    )
    if @user.save
      sign_in_and_redirect @user, :event => :authentication
    else
      render new_user_session_path
    end
  end

  def build_resource(hash=nil)
    if hash != nil
      hash[:uid] = User.create_unique_string
      super
    end
  end
end
