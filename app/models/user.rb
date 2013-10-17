class User < ActiveRecord::Base
  has_many :histries

  validates :uid, presence: true, uniqueness: true

  scope :pending, -> { where(status: :pending) }
  scope :active, -> { where(status: :active) }
  scope :suspended, -> { where(status: :suspended) }

  def pending?
    status == 'pending'
  end

  def active?
    status == 'active'
  end

  def suspended?
    status == 'suspended'
  end
end
