# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  if $("#static_pages_homepage").length > 0
    $(window).resize ->
      m = ($(window).height() - 636) / 2
      m = 30 if m < 30
      $("#crest").css("margin-top", m + "px")
      $("#crest").css("margin-bottom", m + "px")
    $(window).trigger('resize')

$(document).ready(ready)
$(document).on('page:load', ready)