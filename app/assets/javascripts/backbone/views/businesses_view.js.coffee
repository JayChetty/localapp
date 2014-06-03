class Localapp.Views.BusinessesView extends Backbone.View
  template: JST["backbone/templates/businesses"]

  events:
    'click a#business-list-item': 'openBusiness'
    'click a#sign-out': 'signOutOwner'
    'click a#side-bar-button': 'showList'


  getCurrentOwner:=>
    @owners = new Localapp.Collections.CurrentOwners()
    @owners.fetch(
      success: =>
        @renderOwnerButtons()
    )

  signOutOwner:=>   
    $.ajax(
      url: "owners/sign_out"
      type: 'DELETE'
      success:=>
        window.location.reload()
    )

  showList:(ev)=>
    ev.preventDefault() if ev
    $('#side-bar').removeClass('hidden')
    $('#side-bar-button').addClass('hidden') 

  hideList:(ev)=>
    ev.preventDefault() if ev
    $('#side-bar').addClass('hidden')
    $('#side-bar-button').removeClass('hidden') 

    

  renderOwnerButtons:(data)=>
    current_owner = @owners.first()
    if current_owner
      $('#mybusiness').removeClass('hidden')
      $('.user-links').removeClass('hidden') 
    else
      $('#sign-in').removeClass('hidden')


  # signIn:(e)=>
  #   window.location.href = "owners/sign_up"
  mobile:=>
    console.log('screenwidth',$( window ).width())
    $( window ).width() < 800

  addList:=>
    $('#side-main').append("<ul class='business-list'></ul>")
    $('#side-admin').append("<ul class='admin-list'></ul>")
    $('#mybusiness').append("<ul class='my-business-list'></ul>")
    if @mobile()
      @hideList()

  openBusiness:(e)=>
    e.preventDefault() if e
    target = e.target
    leafletId = target.getAttribute('data-marker-id')
    console.log('target',target)
    console.log('lid',target.getAttribute('data-marker-id'))
    @map._layers[leafletId].openPopup()
    console.log('mobile', @mobile())
    if @mobile()
      @hideList()

  renderMapAndList:=>
    console.log('rendermap')
    @map = L.mapbox.map('map', 'jaychetty.i61bedof',
      zoomControl: false
    ).setView([55.9369407, -3.2135925], 14) #Edinburgh
    @map.on('locationfound', @showUser)
    @addList()
    @businessFeatureLayer = L.mapbox.featureLayer()
    @getAndDrawBusinesses()
    @getCurrentOwner()
    if navigator.geolocation
      @map.locate();
    
    # navigator.geolocation.getCurrentPosition(@showPosition)

  showUser:(e)=>
    # @map.fitBounds(e.bounds);
    userFeatureLayer = L.mapbox.featureLayer()
    console.log('show user', e)
    userFeatureLayer.setGeoJSON(
      type: 'Feature'
      geometry: 
          type: 'Point'
          coordinates: [e.latlng.lng, e.latlng.lat]    
      properties: {
          'title': 'You are here',
          'marker-color': '#ff8888',
          'marker-symbol': 'star'
      }
    )
    userFeatureLayer.addTo(@map)  


  render:=>
    $(@el).html(@template()) # not rendering template as too later for mapbox 
    @

  #Add For Auto Update
  update:=>
    console.log('udpate')
    $('.my-business-list').html("")
    $('.business-list').html("")
    @businessFeatureLayer.setGeoJSON([])
    @drawMarkers()

  getAndDrawBusinesses: =>
    @businesses = new Localapp.Collections.Businesses()
    @businesses.fetch(
      success: =>
        @drawMarkers()
    )
    #Add For Auto Update
    @businesses.bind('change', @update)

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
        listItemView = new Localapp.Views.BusinessListItemView(marker: marker)
        console.log('listItemView', listItemView.render().el)
        if properties.owned    
          # $('#mybusiness').html("<h5> My Business </h5> <a id='business-list-item' data-marker-id='#{marker._leaflet_id}'> #{properties.name} </a> ")
          $('.my-business-list').append(listItemView.render().el)
        else
          console.log('properties', properties)
          if properties.business.get('verified') == true
            $('.business-list').append(listItemView.render().el)
          else
            $('#side-admin').removeClass('hidden')
            $('.admin-list').append(listItemView.render().el)
         

  drawMarkers: =>
    geoObjects = []
    @businesses.each((business)=>
      if business.get('longitude') && business.get('longitude')
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



