class Goal < ApplicationRecord
  validates :goal_name, presence: true
  validates :amount, presence: true, numericality: true, format: /\A\d+(?:\.\d{0,2})?\z/

  geocoded_by :location
  after_validation :geocode

  belongs_to :user
  has_many :follows, dependent: :destroy

  mount_uploader :image, ImageUploader


  def followed_by?(user)
  # follows.find_by_user_id user
    follows.exists?(user: user)
  end

  def follow_for(user)
    follows.find_by_user_id user
  end

  def self.mark(goal)
    if goal.mark == "Not Achieved"
      Goal.update(goal, :mark => "Achieved")
    else
      Goal.update(goal, :mark => "Not Achieved")
    end
  end
end
