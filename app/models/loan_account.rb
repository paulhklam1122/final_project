class LoanAccount < ApplicationRecord
  belongs_to :user
  validates :loan_name, presence: true
  validates :balance, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
  validates :monthly_payment, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
