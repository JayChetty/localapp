class Localapp.Views.BusinessModalView extends Backbone.View
  template: JST["backbone/templates/business_modal"]
  tagName: "div" 
  className: "business-modal" 

  render: =>
    $(@el).html(@template(@model.toJSON() ))
    @

  open: =>
    @$(".modal").modal('show')

  hide: =>
    @$(".modal").modal('hide')