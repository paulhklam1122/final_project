class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Profile do |profile|
      profile.user == user
    end

    can :manage, BankAccount do |bank_account|
      bank_account.user == user
    end

    can :manage, Property do |property|
      property.user == user
    end

    can :manage, CreditCard do |credit_card|
      credit_card.user == user
    end

    can :manage, Expense do |expense|
      expense.user == user
    end

    can :manage, Goal do |goal|
      goal.user == user
    end

    can :manage, LoanAccount do |loan_account|
      loan_account.user == user
    end


  end
end
