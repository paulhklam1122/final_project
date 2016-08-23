require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires a first name" do
      u = build(:user, {first_name: nil})
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end
  end
end
