class Program < ActiveRecord::Base
  serialize :extdetail
  serialize :category

  belongs_to :channel

  validates_presence_of :channel_id, :title, :movie_path, :event_id, :started_at, :ended_at, :duration
end
