class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  # validates :income, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/
end
