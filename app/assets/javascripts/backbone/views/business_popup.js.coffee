class Localapp.Views.BusinessPopupView extends Backbone.View
  template: JST["backbone/templates/business_popup"]
  className: 'popup'

  events:
    "click a.show_modal": "openModal"
    "click a.edit_modal": "openEditModal"
    "click a.verify": "verify"

  render:=>
    
    $(@el).html(@template(@options.marker))
    @

  verify:=>
    console.log('verify')

    $.ajax
      type: "POST",
      url: "businesses/#{@options.business.get('id')}/verify"
      success: =>
        alert('verified')
        window.location.reload()
    

  openModal: =>
    map = $('body')[0]
    @modal = new Localapp.Views.BusinessModalView(model: @options.business)
    map.appendChild(@modal.render().el) 
    @modal.open();

  openEditModal: =>
    map = $('body')[0]
    @modal = new Localapp.Views.BusinessEditModalView(model: @options.business)
    map.appendChild(@modal.render().el) 
    @modal.open();    