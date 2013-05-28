playBack = (sec) ->
  video = document.getElementById('video')
  video.currentTime += sec * video.playbackRate

key 'space', ->
  video = document.getElementById('video')
  if video.paused
    video.play()
  else
    video.pause()
  false

key '-', ->
  slider = $('#rate-controller input')
  slider.val((index, value) ->
    value - slider.attr('step'))
  slider.trigger('change')

key '=', ->
  slider = $('#rate-controller input')
  slider.val((index, value) ->
    parseFloat(value) + parseFloat(slider.attr('step')))
  slider.trigger('change')

key 'j', ->
  playBack(15)


key 'k', ->
  playBack(-15)
