class CreditCard < ApplicationRecord
  belongs_to :user
  validates :card_name, presence: true
  validates :monthly_balance, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
