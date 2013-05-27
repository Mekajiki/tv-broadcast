key 'p', ->
  video = document.getElementById('video')
  if video.paused
    video.play()
  else
    video.pause()


key 'j', ->
  video = document.getElementById('video')
  video.currentTime += 15


key 'k', ->
  video = document.getElementById('video')
  video.currentTime -= 15
