class LoanAccountsController < ApplicationController

  def create
    @loan_account = LoanAccount.new loan_account_params
    @loan_account.user = current_user
    if @loan_account.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @loan_account = @user.loan_accounts.find params[:id]
    # respond_to do |format|
      # format.js {render :edit_toggle}
    # end
  end

  def update
    @user = current_user
    @loan_account = @user.loan_accounts.find params[:id]
    # respond_to do |format|
      if @loan_account.update loan_account_params
        redirect_to user_path(current_user), notice: "Loan/Mortgage Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @loan_account = @user.loan_accounts.find params[:id]
    @loan_account.destroy
    # respond_to do |format|
      redirect_to user_path(current_user), notice: "Loan/Mortgage Deleted!"
      # format.js {render}
    # end
  end


  private

  def loan_account_params
    params.require(:loan_account).permit(:loan_name, :balance, :monthly_payment)
  end
end
