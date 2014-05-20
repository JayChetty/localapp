class Localapp.Views.BusinessPopupView extends Backbone.View
  template: JST["backbone/templates/business_popup"]
  className: 'popup'

  events:
    "click a.show_modal": "openModal"

  render:=>
    @modal = new Localapp.Views.BusinessModalView(model: @options.business)
    $(@el).html(@template(@options.marker))
    @

  openModal: =>
    map = $('body')[0]
    map.appendChild(@modal.render().el) 
    @modal.open();