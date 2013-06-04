class Program < ActiveRecord::Base
  serialize :extdetail
  serialize :category
  serialize :attachinfo
  serialize :video
  serialize :audio

  belongs_to :channel

  default_scope order('started_at DESC')

  paginates_per 20

  validates_presence_of :channel_id, :title, :movie_file_name, :event_id, :started_at, :ended_at, :duration

  def is_anime?
    category.to_s.index 'アニメ'
  end

  def movie_uri
    "#{Settings.movie.dir_uri}/#{movie_file_name}"
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

  class << self
    def new_from_epg epg
      channel = Channel.find_or_create_by(id_string: epg['channel'])
      Program.new({
        channel: channel,
        event_id: epg['event_id'],
        freeCA: epg['freeCA'],
        audio: epg['audio'],
        video: epg['video'],
        attachinfo: epg['attachinfo'],
        title: epg['title'],
        detail: epg['detail'],
        extdetail: epg['extdetail'],
        started_at: datetime_from_epg_timestamp(epg['start']),
        ended_at: datetime_from_epg_timestamp(epg['end']),
        duration: epg['duration'],
        category: epg['category']
      })
    end

    private
    def datetime_from_epg_timestamp timestamp
      unix_time = timestamp / 10000
      Time.at(unix_time).to_datetime
    end
  end
end
