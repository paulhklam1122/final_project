class PropertiesController < ApplicationController
  def create
    @property = Property.new property_params
    @property.user = current_user
    if @property.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @property = @user.properties.find params[:id]
    # respond_to do |format|
      # format.js {render :edit_toggle}
    # end
  end

  def update
    @user = current_user
    @property = @user.properties.find params[:id]
    # respond_to do |format|
      if @property.update property_params
        redirect_to user_path(current_user), notice: "Property Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @property = @user.properties.find params[:id]
    @property.destroy
    # respond_to do |format|
    redirect_to user_path(current_user), notice: "Property Deleted!"
      # format.js {render}
    # end
  end

  private

  def property_params
    params.require(:property).permit(:name, :value)
  end

end
