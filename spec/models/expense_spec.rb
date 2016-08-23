require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe "validations" do
    it "requires an expense name" do
      e = build(:expense, {expense_name: nil})
      e.valid?
      expect(e.errors).to have_key(:expense_name)
    end

    it "requires an amount" do
      e = build(:expense, {amount: nil})
      e.valid?
      expect(e.errors).to have_key(:amount)
    end

    it "requires a valid amount" do
      e = build(:expense, {amount: "I'm an invalid amount"})
      e.valid?
      expect(e.errors).to have_key(:amount)
    end
  end
end
