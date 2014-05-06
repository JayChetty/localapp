# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  alert "page has loaded!"
  console.log($('#map')[0])
  map = L.mapbox.map('map', 'jaychetty.i61bedof').setView([40, -74.50], 9)

# window.onload(
#   console.log('loaded', $('#map'))
#   map = L.mapbox.map('map', 'jaychetty.i61c8nd7').setView([45.52086, -122.679523], 14)
# )
# console.log('in here asd')

# $.ajax
#   dataType: 'text'
#   url: 'businesses/general_index.json'
#   success: (data) ->
#     geojson = $.parseJSON(data)
#     map.featureLayer.setGeoJSON(geojson)