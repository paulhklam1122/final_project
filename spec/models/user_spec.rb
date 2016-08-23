require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires a first name" do
      u = build(:user, {first_name: nil})
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end

    it "requires a last name" do
      u = build(:user, {last_name: nil})
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end

    it "requires an email" do
      u = build(:user, {email: nil})
      u.valid?
      expect(u.errors).to have_key(:email)
    end

    it "requires the email to be unique" do
      u = build(:user, {email: "I'm an invalid email"})
      u.valid?
      expect(u.errors).to have_key(:email)
    end
  end
  describe "full_name" do
    it "returns the titleized version of ths user's name" do
      u = build(:user,{first_name: "paul", last_name: "lam"})
      expect(u.full_name).to eq("Paul Lam")
    end
  end
end
