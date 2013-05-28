$ ->
  $('#rate-controller input').change (event) ->
      video = document.getElementById('video')
      wasPlaying = !video.paused
      if wasPlaying
        video.pause()
      video.playbackRate = event.target.value
      $('#rate-indicator').html('x' + video.playbackRate.toFixed(2))
      if wasPlaying
        video.play()
