require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe "validations" do
    it "requires a goal name" do
      g = build(:goal, {goal_name: nil})
      g.valid?
      expect(g.errors).to have_key(:goal_name)
    end

    it "requires an amount" do
      g = build(:goal, {amount: nil})
      g.valid?
      expect(g.errors).to have_key(:amount)
    end

    it "requires a valid amount" do
      g = build(:goal, {amount: "I'm an invalid amount"})
      g.valid?
      expect(g.errors).to have_key(:amount)
    end
  end
end
