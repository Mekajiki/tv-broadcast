class Program < ActiveRecord::Base
  serialize :extdetail
  serialize :category
  serialize :attachinfo
  serialize :video
  serialize :audio

  belongs_to :channel

  has_many :gif_animations

  default_scope { order('started_at DESC') }

  paginates_per 20

  validates_presence_of :title, :movie_file_name, :duration, :started_at, :ended_at

  def is_anime?
    category.to_s.index 'アニメ'
  end

  def movie_uri
    "#{Settings.movie.dir_uri}/#{movie_file_name}"
  end

  def movie_absolute_path
    "#{Settings.movie.storage}/#{movie_file_name}"
  end

  def farther_detail
    extdetail || []
  end

  def duration_s
    minutes = duration / 60
    hour = 0
    while minutes >= 60
      minutes -= 60
      hour += 1
    end
    "%d:%02d" % [hour, minutes]
  end

  def channel_name
    channel ? channel.name : 'Uploaded'
  end
end
