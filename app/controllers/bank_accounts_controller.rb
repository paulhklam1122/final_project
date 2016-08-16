class BankAccountsController < ApplicationController
  def create
    @bank_account = BankAccount.new bank_account_params
    @bank_account.user = current_user
    if @bank_account.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @bank_account = @user.bank_accounts.find params[:id]
    # respond_to do |format|
    #   format.js {render :edit_toggle}
    # end
  end

  def update
    @user = current_user
    @bank_account = @user.bank_accounts.find params[:id]
    # respond_to do |format|
      if @bank_account.update bank_account_params
        redirect_to user_path(current_user), notice: "Bank Account Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @bank_account = @user.bank_accounts.find params[:id]
    @bank_account.destroy
    respond_to do |format|
      format.html {redirect_to user_path(current_user), notice: "Bank Account Deleted!"}
      format.js {render}
    end
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:bank_name, :account_type, :account_balance)
  end
end
