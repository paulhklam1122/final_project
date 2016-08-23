require 'rails_helper'

RSpec.describe Property, type: :model do
  describe "validations" do
    it "requires a name" do
      p = build(:property, {name: nil})
      p.valid?
      expect(p.errors).to have_key(:name)
    end

    it "requires a value" do
      p = build(:property, {value: nil})
      p.valid?
      expect(p.errors).to have_key(:value)
    end

    it "requires a valid value" do
      p = build(:property, {value: "I'm an invalid value"})
      p.valid?
      expect(p.errors).to have_key(:value)
    end
  end
end
