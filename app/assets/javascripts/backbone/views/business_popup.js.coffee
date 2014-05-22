class Localapp.Views.BusinessPopupView extends Backbone.View
  template: JST["backbone/templates/business_popup"]
  className: 'popup'

  events:
    "click a.show_modal": "openModal"
    "click a.edit_modal": "openEditModal"

  render:=>
    
    $(@el).html(@template(@options.marker))
    @

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