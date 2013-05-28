key 'p', ->
  video = document.getElementById('video')
  if video.paused
    video.play()
  else
    video.pause()

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
  video = document.getElementById('video')
  video.currentTime += 15


key 'k', ->
  video = document.getElementById('video')
  video.currentTime -= 15
