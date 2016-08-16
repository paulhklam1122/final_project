class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :show, :create, :index]
  def index
      @users = User.order("first_name ASC").page(params[:page]).per(15)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
    @profile = @user.profile
    @bank_accounts = @user.bank_accounts
    @properties = @user.properties
      @loan_accounts = @user.loan_accounts
    @credit_cards = @user.credit_cards
    @expenses = @user.expenses
    @goals = @user.goals

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
               :type=> 'pie',
               :name=> 'Browser share',
               :data=> [
                  ['Assets', total_assets],
                  ['Debt', total_debt],
               ]
             }
      f.series(series)
      f.options[:title][:text] = "Lets see how you are doing!"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
      f.plot_options(:pie=>{
        :allowPointSelect=>true,
        :cursor=>"pointer" ,
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end

    @graph = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'Income',:data=> [monthly_income])
      f.series(:name=>'Expenditure',:data=> [monthly_expenditures])
      f.title({ :text=>"Monthly Cash Flow"})
      f.legend({:align => 'right',
                :x => -100,
                :verticalAlign=>'top',
                :y=>20,
                :floating=>"true",
                :backgroundColor=>'#FFFFFF',
                :borderColor=>'#CCC',
                :borderWidth=>1,
                :shadow=>"false"
               })
      f.options[:chart][:defaultSeriesType] = "column"
      f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Monthly Cash Flow"}, :categories => [" "]}
      f.options[:yAxis][:title] = {:text=>"Amount ($)"}
      f.plotOptions(series: {
        :cursor => 'pointer',
        :point => {:events => {:click => "click_function"} }
      })
    end

  end

  def edit
    @user = current_user
    @profile = @user.profile
    @bank_account = BankAccount.new
    @property = Property.new
    @loan_account = LoanAccount.new
    @credit_card = CreditCard.new
    @expense = Expense.new
    @goal = Goal.new
  end

  def update_password
    @user = User.find session[:user_id]
    if @user.authenticate(params[:current_password])
      if params[:new_password] == params[:new_password_confirmation]
        @user.update password: params[:new_password]
        sign_in(@user)
        redirect_to root_path, notice: "Password Successfully Changed!"
      else
        flash[:alert] = "Your new password and confirmation do not match."
        render :change_password
      end
    else
      flash[:alert] = "The password you entered doesn't match the one in our records."
      render :change_password
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, profile_attributes: [:income])
  end

  def total_assets
    BankAccount.where(user_id: @user.id).sum(:account_balance) + Property.where(user_id: @user.id).sum(:value)
  end
  helper_method :total_assets

  def total_debt
    LoanAccount.where(user_id: @user.id).sum(:balance) + CreditCard.where(user_id: @user.id).sum(:monthly_balance)
  end
  helper_method :total_debt

  def monthly_income
    (Profile.where(user_id: @user.id).sum(:income) / 12).round(2)
  end
  helper_method :monthly_income

  def monthly_expenditures
    (LoanAccount.where(user_id: @user.id).sum(:monthly_payment) + CreditCard.where(user_id: @user.id).sum(:monthly_balance) + Expense.where(user_id: @user.id).sum(:amount)).round(2)
  end
  helper_method :monthly_expenditures

  def monthly_net_income
    monthly_income - monthly_expenditures
  end
  helper_method :monthly_net_income

  def monthly_net_mortgage_income
    (Profile.where(user_id: @user.id).sum(:income) / 12).round(2) - (LoanAccount.where(user_id: @user.id).sum(:monthly_payment)).round(2)
  end
  helper_method :monthly_net_mortgage_income

  def monthly_mortgage_payments
    (LoanAccount.where(user_id: @user.id).sum(:monthly_payment)).round(2)
  end
  helper_method :monthly_mortgage_payments

  def monthly_loan_payments
    (LoanAccount.where(user_id: @user.id).sum(:monthly_payment)).round(2) + (CreditCard.where(user_id: @user.id).sum(:monthly_balance)).round(2)
  end
  helper_method :monthly_loan_payments

end
