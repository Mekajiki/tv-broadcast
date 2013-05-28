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

key 'ctrl+j', ->
  playBack(60)

key 'k', ->
  playBack(-15)

key 'ctrl+k', ->
  playBack(-60)

key 'h', ->
  playBack(-3 * 60)

key 'ctrl+h', ->
  playBack(-10 * 60)

key 'l', ->
  playBack(3 * 60)

key 'ctrl+l', ->
  playBack(10 * 60)
