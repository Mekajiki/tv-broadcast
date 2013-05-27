class Channel < ActiveRecord::Base
  has_many :programs

  validates_presence_of :id_string

  def program_id
    id_string.split('_')[1]
  end
end
