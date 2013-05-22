$ ->
  $('#rate-slider').slider({
    value:1.0
    min:0.5
    max:2.0
    step: 0.25
    change: (event, ui) ->
      $('#rate-indicator').html('x' + ui.value.toFixed(2))
  })
