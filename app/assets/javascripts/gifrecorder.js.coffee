class window.GifRecorder
  constructor: (videoId, postPath) ->
    @video = document.getElementById(videoId)
    @postPath = postPath
    @recording = false

  toggleState: ->
    if @recording
      @endAt = @video.currentTime

      $.ajax {
        type: 'POST'
        url: @postPath
        data: {
          start_at: @startAt
          end_at: @endAt }
        success: (data) ->
          $.fileDownload data.path
      }
    else
      @startAt = @video.currentTime
    @recording = !@recording
