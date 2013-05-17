class Channel < ActiveRecord::Base
  has_many :programs

  validates_presence_of :id_string
end
