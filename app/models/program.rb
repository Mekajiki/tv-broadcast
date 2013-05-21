class Program < ActiveRecord::Base
  serialize :extdetail
  serialize :category
  serialize :attachinfo
  serialize :video
  serialize :audio

  belongs_to :channel

  default_scope order('started_at DESC')

  validates_presence_of :channel_id, :title, :movie_path, :event_id, :started_at, :ended_at, :duration

  def is_anime?
    category.to_s.index 'アニメ'
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
