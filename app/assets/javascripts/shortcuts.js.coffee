playBack = (sec) ->
  video = document.getElementById('video')
  video.currentTime += sec * video.playbackRate

key 'space', 'theater', ->
  video = document.getElementById('video')
  if video.paused
    video.play()
  else
    video.pause()
  false

key '-', 'theater', ->
  slider = $('#rate-controller input')
  slider.val (index, value) ->
    value - slider.attr('step')
  slider.trigger('change')

key '=', 'theater', ->
  slider = $('#rate-controller input')
  slider.val (index, value) ->
    parseFloat(value) + parseFloat(slider.attr('step'))
  slider.trigger('change')

key 'j', 'theater', ->
  playBack(15)

key 'ctrl+j', 'theater', ->
  playBack(60)

key 'k', 'theater', ->
  playBack(-15)

key 'ctrl+k', 'theater', ->
  playBack(-60)

key 'h', 'theater', ->
  playBack(-3 * 60)

key 'ctrl+h', 'theater', ->
  playBack(-10 * 60)

key 'l', 'theater', ->
  playBack(3 * 60)

key 'ctrl+l', 'theater', ->
  playBack(10 * 60)

key 'u', 'theater', ->
  Turbolinks.visit('/programs')
