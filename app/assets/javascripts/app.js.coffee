ready = ->
  $(window).resize ->
    $('#container').css('min-height', ($(window).height() - 195) + 'px')
  $(window).trigger('resize')

$(document).ready(ready)
$(document).on('page:load', ready)