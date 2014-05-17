class Localapp.Views.BusinessesView extends Backbone.View
  template: JST["backbone/templates/businesses"]
  render:=>
    $(@el).html(@template())
    @map = L.mapbox.map('map', 'jaychetty.i61bedof').setView([55.9369407, -3.2135925], 14) #Edinburgh
    @getAndDrawBusinesses()
    @

  getAndDrawBusinesses: =>
    @businesses = new Localapp.Collections.Businesses()
    @businesses.fetch(
      success: =>
        @drawBusinesess()
    )

    # add custom popups to each marker
    @map.featureLayer.on 'layeradd', (e) ->
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

  drawBusinesess: =>
    geoObjects = []
    @businesses.each((business)=>
      geoObjects.push({
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [business.get('longitude'), business.get('latitude')]
        },
        properties: {
          name: business.get('name'),
          address: business.get('address'),
          'marker-color': '#00607d',
          'marker-symbol': 'circle',
          'marker-size': 'medium'
        }    
      })
    )
    @map.featureLayer.setGeoJSON(geoObjects)
