class Expense < ApplicationRecord
  belongs_to :user
  validates :expense_name, presence: true
  validates :amount, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
