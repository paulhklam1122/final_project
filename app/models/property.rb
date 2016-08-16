class Property < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :value, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
