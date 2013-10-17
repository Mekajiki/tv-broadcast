class window.TimeRecorder
  constructor: (elementId, postUrl, userId, programId) ->
    @video = document.getElementById(elementId)

    setInterval(
      ->
        $.ajax {
          type: 'POST'
          url: postUrl
          data: {
            time: @video.currentTime
            userId: userId
            programId: programId
          }
        }
      , 5000)
