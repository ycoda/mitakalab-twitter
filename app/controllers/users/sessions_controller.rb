class Users::SessionsController < Devise::SessionsController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user
      sign_in_and_redirect @user, :event => :authentication
    else
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
