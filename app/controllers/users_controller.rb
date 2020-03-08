class UsersController < ApplicationController

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

  def authenticate_action!
    redirect_to user_path(current_user) unless current_user.id == params[:id].to_i
  end

end
