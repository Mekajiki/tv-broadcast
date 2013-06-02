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
  playBack(5)

key 'ctrl+j', 'theater', ->
  playBack(30)

key 'k', 'theater', ->
  playBack(-5)

key 'ctrl+k', 'theater', ->
  playBack(-30)

key 'h', 'theater', ->
  playBack(-60)

key 'ctrl+h', 'theater', ->
  playBack(-5 * 60)

key 'l', 'theater', ->
  playBack(60)

key 'ctrl+l', 'theater', ->
  playBack(5 * 60)

key 'u', 'theater', ->
  Turbolinks.visit('/programs')

key 'shift+/', ->
  $('#shortcut-help').toggleClass('hidden')
