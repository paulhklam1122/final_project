class ExpensesController < ApplicationController
  def create
    @expense = Expense.new expense_params
    @expense.user = current_user
    if @expense.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @expense = @user.expenses.find params[:id]
    # respond_to do |format|
    #   format.js {render :edit_toggle}
    # end
  end

  def update
    @user = current_user
    @expense = @user.expenses.find params[:id]
    # respond_to do |format|
      if @expense.update expense_params
        redirect_to user_path(current_user), notice: "Expense Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @expense = @user.expenses.find params[:id]
    @expense.destroy
    # respond_to do |format|
    redirect_to user_path(current_user), notice: "Expense Deleted!"
      # format.js {render}
    # end
  end

  private

  def expense_params
    params.require(:expense).permit(:expense_name, :amount)
  end
end
