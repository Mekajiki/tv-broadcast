class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true

  scope :pending, -> { where(status: :pending) }
  scope :active, -> { where(status: :active) }
  scope :suspended, -> { where(status: :suspended) }
end
