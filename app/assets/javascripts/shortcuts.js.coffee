# shortcuts for playback
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

key 'f', 'theater', ->
  video = document.getElementById('video')
  if video.requestFullscreen
    video.requestFullscreen()
  else if video.mozRequestFullScreen
    video.mozRequestFullScreen()
  else if video.webkitRequestFullscreen
    video.webkitRequestFullscreen()

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
  history.back()

key 'shift+/', ->
  $('#shortcut-help').toggleClass('hidden')

# shortcuts for programs list
key '/', ->
  $('#program_filter_keyword').focus()
  false

$(document).keyup (event) ->
  if event.keyCode == 27
    $('input[type=text]').blur()
