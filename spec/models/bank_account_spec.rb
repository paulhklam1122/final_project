require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe "validations" do
    it "requires a bank name" do
      b = build(:bank_account, {bank_name: nil})
      b.valid?
      expect(b.errors).to have_key(:bank_name)
    end

    it "requires a account type" do
      b = build(:bank_account, {account_type: nil})
      b.valid?
      expect(b.errors).to have_key(:account_type)
    end

    it "requires a account balance" do
      b = build(:bank_account, {account_balance: nil})
      b.valid?
      expect(b.errors).to have_key(:account_balance)
    end

    it "requires a valid account balance" do
      b = build(:bank_account, {account_balance: "I'm an invalid account balance"})
      b.valid?
      expect(b.errors).to have_key(:account_balance)
    end
  end
end
