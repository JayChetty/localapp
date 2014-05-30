class Localapp.Views.BusinessesView extends Backbone.View
  template: JST["backbone/templates/businesses"]

  events:
    'click a#business-list-item': 'openBusiness'

  addList:=>
    $('#list').html('<ul></ul>')
    $('#adminlist').html('<ul></ul>')

  openBusiness:(e)=>
    e.preventDefault() if e
    target = e.target
    leafletId = target.getAttribute('data-marker-id')
    console.log('target',target)
    console.log('lid',target.getAttribute('data-marker-id'))
    @map._layers[leafletId].openPopup()

  renderMapAndList:=>
    @map = L.mapbox.map('map', 'jaychetty.i61bedof').setView([55.9369407, -3.2135925], 14) #Edinburgh
    @addList()
    @businessFeatureLayer = L.mapbox.featureLayer()
    @getAndDrawBusinesses()     

  render:=>
    $(@el).html(@template()) # not rendering template as too later for mapbox 
    @

  getAndDrawBusinesses: =>
    @businesses = new Localapp.Collections.Businesses()
    @businesses.fetch(
      success: =>
        @drawMarkers()
    )

    @businessFeatureLayer.on 'layeradd', (e) ->
      marker = e.layer
      properties = marker.feature.properties

      # create custom popup
      if properties.business
        popupView = new Localapp.Views.BusinessPopupView(marker: properties, business: properties.business)
        popupContent = popupView.render().el
        # http://leafletjs.com/reference.html#popup
        marker.bindPopup popupContent,
          closeButton: true
          minWidth: 320
      if properties.owned    
        $('#mybusiness').html("<h5> My Business </h5> <a id='business-list-item' data-marker-id='#{marker._leaflet_id}'> #{properties.name} </a>")
      else
        console.log('properties', properties)
        if properties.business.get('verified') == true
          $('#list').append("<li> <a id='business-list-item' data-marker-id='#{marker._leaflet_id}'> #{properties.name} </a></li>")
        else
          $('#admin-list').removeClass('hidden')
          $('#admin-list').append("<li> <a id='business-list-item' data-marker-id='#{marker._leaflet_id}'> #{properties.name} </a></li>")
         

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
            business: business
            owned: true
            name: business.get('name')
            address: business.get('address')
            'marker-color': '#990000'
            'marker-symbol': 'circle'
            'marker-size': 'medium'          
        )
      else
        geoObjects.push(
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
   
    @businessFeatureLayer.setGeoJSON(geoObjects)
    @businessFeatureLayer.addTo(@map)



