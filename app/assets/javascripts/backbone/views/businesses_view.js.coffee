class Localapp.Views.BusinessesView extends Backbone.View
  template: JST["backbone/templates/businesses"]

  initialize:(options)=>
    @geoObjects = []
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

    # @map.featureLayer.on 'layeradd', (e) ->
    #   console.log('layer add', e)
    #   marker = e.layer
    #   properties = marker.feature.properties

    #   # create custom popup
    #   if properties.business
    #     console.log('has business')
    #     popupView = new Localapp.Views.BusinessPopupView(marker: properties, business: properties.business)
    #     popupContent = popupView.render().el
    #     # http://leafletjs.com/reference.html#popup
    #     marker.bindPopup popupContent,
    #       closeButton: true
    #       minWidth: 320

         

  drawMarkers: =>
    @businesses.each((business)=>
      if business.get('has_current_owner')
        @geoObjects.push(
          type: 'Feature'
          geometry:
            type: 'Point'
            coordinates: [business.get('longitude'), business.get('latitude')]          
          properties:
            business: business  
            owned: true
            name: business.get('name')
            address: business.get('address')
            'marker-color': '#990000'
            'marker-symbol': 'circle'
            'marker-size': 'medium'          
        )
      else
        @geoObjects.push(
          type: 'Feature'
          geometry: 
            type: 'Point'
            coordinates: [business.get('longitude'), business.get('latitude')]     
          properties:
            business: business   
            owned: false
            name: business.get('name')
            address: business.get('address')
            'marker-color': '#00607d'
            'marker-symbol': 'circle'
            'marker-size': 'medium'                
        )
    )
    console.log('drawing markers', @geoObjects)
    console.log('drawing markers length', @geoObjects.length)
    # @map.featureLayer.setGeoJSON(geoObjects)
    @map.featureLayer.setGeoJSON(@geoObjects)
    console.log('feature layer', @map.featureLayer)
    window.featureLayer = @map.featureLayer
    window.geoObjects = @geoObjects
    # if @map.featureLayer._geojson.length == undefined
    #   console.log('no features', geoObjects)
    #   @map.featureLayer.setGeoJSON(geoObjects)
    # add custom popups to each marker



