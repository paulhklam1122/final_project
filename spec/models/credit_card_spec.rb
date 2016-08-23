require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe "validations" do
    it "requires a card name" do
      c = build(:credit_card, {card_name: nil})
      c.valid?
      expect(c.errors).to have_key(:card_name)
    end

    it "requires a monthly balance" do
      c = build(:credit_card, {monthly_balance: nil})
      c.valid?
      expect(c.errors).to have_key(:monthly_balance)
    end

    it "requies a valid monthly balance" do
      c = build(:credit_card, {monthly_balance: "I'm an invalid monthly balance"})
      c.valid?
      expect(c.errors).to have_key(:monthly_balance)
    end
  end
end
