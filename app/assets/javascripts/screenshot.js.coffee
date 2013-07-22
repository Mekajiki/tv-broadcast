class window.Screenshot
  constructor: (videoId, canvasId, imageId, scale) ->
    @video = document.getElementById(videoId)
    @canvas = document.getElementById(canvasId)
    @context = @canvas.getContext('2d')
    @image = document.getElementById(imageId)
    @scale = scale

    @video.addEventListener 'loadedmetadata', (event) =>
      @width = @video.videoWidth * @scale
      @height = @video.videoHeight * @scale

  take: ->
    if @width? and @height?
      @canvas.width = @width
      @canvas.height = @height
      @context.fillRect(0, 0, @width, @height)
      @context.drawImage(@video, 0, 0, @width, @height)
      @image.src = @canvas.toDataURL('image/png')
