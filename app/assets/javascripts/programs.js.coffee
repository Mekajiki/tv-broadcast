$ ->
  $('#rate-controller input').change((event) ->
      video = document.getElementById('video')
      video.playbackRate = event.target.value
      $('#rate-indicator').html('x' + video.playbackRate.toFixed(2))
  )
