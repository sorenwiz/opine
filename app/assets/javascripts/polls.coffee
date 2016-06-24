# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $('body').on 'click', '.js-card-clickable', ->
    card_href = $(this).data('href')
    if card_href.length
      window.location = card_href
      return false
