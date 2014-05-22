class Localapp.Views.BusinessEditModalView extends Backbone.View
  template: JST["backbone/templates/business_edit_modal"]
  tagName: "div" 
  className: "business-edit-modal" 

  render: =>
    $(@el).html(@template(@model.toJSON() ))
    @

  open: =>
    @$(".modal").modal('show')

  hide: =>
    @$(".modal").modal('hide')