class CreditCardsController < ApplicationController

  def create
    @credit_card = CreditCard.new credit_card_params
    @credit_card.user = current_user
    if @credit_card.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @credit_card = @user.credit_cards.find params[:id]
    # respond_to do |format|
    #   format.js {render :edit_toggle}
    # end
  end

  def update
    @user = current_user
    @credit_card = @user.credit_cards.find params[:id]
    # respond_to do |format|
      if @credit_card.update credit_card_params
        redirect_to user_path(current_user), notice: "Credit Card Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @credit_card = @user.credit_cards.find params[:id]
    @credit_card.destroy
    # respond_to do |format|
    redirect_to user_path(current_user), notice: "Credit Card Deleted!"
      # format.js {render}
    # end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:card_name, :monthly_balance)
  end
end
