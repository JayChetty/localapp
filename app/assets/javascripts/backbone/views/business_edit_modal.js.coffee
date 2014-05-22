class Localapp.Views.BusinessEditModalView extends Backbone.View
  template: JST["backbone/templates/business_edit_modal"]
  tagName: "div" 
  className: "business-edit-modal"

  events:
    "click a#save" : "save"

  save : (e) =>
    e.preventDefault()
    e.stopPropagation()
    description = $(@el).find('#description-text').val()
    @model.set('description', description)
    @model.save()
    @hide()

  render: =>
    $(@el).html(@template(@model.toJSON()))
    @

  open: =>
    @$(".modal").modal('show')

  hide: =>
    @$(".modal").modal('hide')