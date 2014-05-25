class Localapp.Views.BusinessesView extends Backbone.View
  template: JST["backbone/templates/businesses"]
  render:=>
    # $(@el).html(@template()) # not rendering template as too later for mapbox
    @map = L.mapbox.map('map', 'jaychetty.i61bedof').setView([55.9369407, -3.2135925], 14) #Edinburgh
    @getAndDrawBusinesses()
    @

  getAndDrawBusinesses: =>
    @businesses = new Localapp.Collections.Businesses()
    @businesses.fetch(
      success: =>
        @drawMarkers()
    )

    @map.featureLayer.on 'layeradd', (e) ->
      marker = e.layer
      properties = marker.feature.properties

      # create custom popup
      popupView = new Localapp.Views.BusinessPopupView(marker: properties, business: marker.feature.business)
      popupContent = popupView.render().el
      # http://leafletjs.com/reference.html#popup
      marker.bindPopup popupContent,
        closeButton: false
        minWidth: 320


  drawMarkers: =>
    geoObjects = []
    @businesses.each((business)=>
      if business.get('has_current_owner')
        geoObjects.push(
          type: 'Feature'
          geometry:
            type: 'Point'
            coordinates: [business.get('longitude'), business.get('latitude')]          
          properties: 
            owned: true
            name: business.get('name')
            address: business.get('address')
            'marker-color': '#990000'
            'marker-symbol': 'circle'
            'marker-size': 'medium'
          business: business    
        )
      else
        geoObjects.push(
          type: 'Feature'
          geometry: 
            type: 'Point'
            coordinates: [business.get('longitude'), business.get('latitude')]     
          properties: 
            owned: false
            name: business.get('name')
            address: business.get('address')
            'marker-color': '#00607d'
            'marker-symbol': 'circle'
            'marker-size': 'medium'      
          business: business    
        )
    )
    console.log('drawing markers', geoObjects)
    @map.featureLayer.setGeoJSON(geoObjects)
    # add custom popups to each marker



