class window.TimeRecorder
  constructor: (elementId, url, programId) ->
    @video = document.getElementById(elementId)
    @url = url
    @programId = programId

    setInterval @post, 500

  post: =>
    $.ajax
      type: 'POST'
      url: @url
      data:
        time: @video.currentTime
        program_id: @programId
        authenticity_token: window.__authenticityToken__
