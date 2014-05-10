# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  console.log($('#map')[0])
  map = L.mapbox.map('map', 'jaychetty.i61bedof').setView([55.9369407, -3.2135925], 14)

  $.ajax
    dataType: 'text'
    url: 'businesses/general_index.json'
    success: (data) ->
      console.log('success')
      geojson = $.parseJSON(data)
      map.featureLayer.setGeoJSON(geojson)

  # add custom popups to each marker
  map.featureLayer.on 'layeradd', (e) ->
    marker = e.layer
    properties = marker.feature.properties

    # create custom popup
    popupContent =  '<div class="popup">' +
                      '<h3>' + properties.name + '</h3>' +
                      '<p>' + properties.address + '</p>' +
                    '</div>'

    # http://leafletjs.com/reference.html#popup
    marker.bindPopup popupContent,
      closeButton: false
      minWidth: 320      

