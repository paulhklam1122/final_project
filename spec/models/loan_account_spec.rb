require 'rails_helper'

RSpec.describe LoanAccount, type: :model do
  describe "validations" do
    it "requires a loan name" do
      l = build(:loan_account, {loan_name: nil})
      l.valid?
      expect(l.errors).to have_key(:loan_name)
    end
    it "requires a balance" do
      l = build(:loan_account, {balance: nil})
      l.valid?
      expect(l.errors).to have_key(:balance)
    end

    it "requires a valid balance" do
      l = build(:loan_account, {balance: "I'm an invalid balance"})
      l.valid?
      expect(l.errors).to have_key(:balance)
    end

    it "requires a monthly payment" do
      l = build(:loan_account, {monthly_payment: nil})
      l.valid?
      expect(l.errors).to have_key(:monthly_payment)
    end

    it "requires a valid monthly payment" do
      l = build(:loan_account, {balance: "I'm an invalid monthly_payment"})
      l.valid?
      expect(l.errors).to have_key(:monthly_payment)
    end
  end
end
