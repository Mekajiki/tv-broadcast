class window.Screenshot
  constructor: (videoId, canvasId, imageId) ->
    @video = document.getElementById(videoId)
    @canvas = document.getElementById(canvasId)
    @context = @canvas.getContext('2d')
    @image = document.getElementById(imageId)

    @video.addEventListener 'loadedmetadata', (event) =>
      @width = @video.videoWidth
      @height = @video.videoHeight

  take: ->
    if @width? and @height?
      @canvas.width = @width
      @canvas.height = @height
      @context.fillRect(0, 0, @width, @height)
      @context.drawImage(@video, 0, 0, @width, @height)
      @image.src = @canvas.toDataURL('image/png')
