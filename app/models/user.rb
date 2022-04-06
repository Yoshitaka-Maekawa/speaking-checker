class User < ApplicationRecord
  has_many :total_results
  has_many :recording_results, through: :total_results
  validates :user_digest, presence: true
  attr_accessor :uuid

  def authenticated?(uuid)
    BCrypt::Password.new(user_digest) == uuid
  end

  class << self
    def create_anonymous!
      uuid = new_uuid
      user = new(
        uuid: uuid,
        user_digest: digest(uuid)
      )
      user.save!
      user
    end

    private

    def new_uuid
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
