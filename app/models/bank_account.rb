class BankAccount < ApplicationRecord
  belongs_to :user
  validates :bank_name, presence: true
  validates :account_type, presence: true
  validates :account_balance, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
