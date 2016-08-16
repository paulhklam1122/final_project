class ProfilesController < ApplicationController

  def edit
    @user = User.find params[:user_id]
    @profile = Profile.find params[:id]
  end

  def update
    @user = User.find params[:user_id]
    @profile = Profile.find params[:id]
    if @profile.update profile_params
      redirect_to edit_user_path(current_user), notice: "Profile Updated"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:income, :avatar)

  end
  # def edit
  #   @user = User.find(params[:id])
  #   @real_estate = @user.assets.real_estate_properties
  #   @real_estate.update_attributes(real_estate_params)
  # end


  # def real_estate_params
  #   # params(:real_estate_properties).permit().require(:worth)
  # end

end
