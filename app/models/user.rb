class User < ApplicationRecord

  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :mortgage_calculator, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :loan_accounts, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followed_goals, through: :follows, source: :goal

  validates :first_name, presence: true, unless: :using_omniauth?
  validates :last_name, presence: true, unless: :using_omniauth?
  validates :email, presence: true, uniqueness: true, format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :using_omniauth?
  validates :uid, uniqueness: {scope: :provider}, if: :using_omniauth?

  after_create :create_profile

  serialize :google_raw_data, Hash

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def followed_by?(user)
    follows.exists?(user: user)
  end

  def follow_for(user)
    follows.find_by_user_id user
  end

  def self.find_or_create_from_google(google_data)
    user = User.where(uid: google_data["uid"], provider: google_data["provider"]).first
    user = create_from_google(google_data) unless user
    user
  end

  def self.create_from_google(google_data)
    user = User.new
    full_name               = google_data["info"]["name"].split(" ")
    user.first_name        = full_name.first
    user.last_name         = full_name.last
    user.uid                 = google_data["uid"]
    user.provider            = google_data["provider"]
    user.google_token      = google_data["credentials"]["token"]
    user.google_secret     = google_data["credentials"]["secret"]
    user.google_raw_data = google_data
    user.password = SecureRandom.urlsafe_base64
    user.save
    user
  end


  def self.find_or_create_from_facebook(facebook_data)
    user = User.where(uid: facebook_data["uid"], provider: facebook_data["provider"]).first
    user = create_from_facebook(facebook_data) unless user
    user
  end

  def self.create_from_facebook(facebook_data)
    user = User.new
    full_name               = facebook_data["info"]["name"].split(" ")
    user.first_name        = full_name.first
    user.last_name         = full_name.last
    user.uid                 = facebook_data["uid"]
    user.provider            = facebook_data["provider"]
    user.facebook_token      = facebook_data["credentials"]["token"]
    user.facebook_secret     = facebook_data["credentials"]["secret"]
    user.facebook_raw_data = facebook_data
    user.password = SecureRandom.urlsafe_base64
    user.save
    user
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    PasswordResetsMailer.password_reset(self).deliver_now
  end

  private

  def using_omniauth?
    uid.present? && provider.present?
  end
end
