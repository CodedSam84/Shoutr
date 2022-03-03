class UsersController < Clearance::UsersController
  def show
    @user = User.find_by_username(params[:id])
    @user? @shouts = @user.shouts : redirect
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def redirect
    redirect_to root_path, alert: "User not found..."
  end
end