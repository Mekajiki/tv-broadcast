$ ->
  $('#rate-slider').slider({
    value:1.0
    min:0.5
    max:2.0
    step: 0.25
    change: (event, ui) ->
      video = document.getElementById('video')
      video.playbackRate = ui.value
      $('#rate-indicator').html('x' + video.playbackRate.toFixed(2))
  })
