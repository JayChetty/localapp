class Localapp.Views.BusinessPopupView extends Backbone.View
  template: JST["backbone/templates/business_popup"]
  className: 'popup'
  render:=>
    $(@el).html(@template(@options.marker))
    @