class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
end
