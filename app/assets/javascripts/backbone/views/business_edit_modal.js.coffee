class Localapp.Views.BusinessEditModalView extends Backbone.View
  template: JST["backbone/templates/business_edit_modal"]
  tagName: "div" 
  className: "business-edit-modal"

  events:
    "click a#save" : "save"

  save : (e) =>
    e.preventDefault()
    e.stopPropagation()
    license = @$('#license').prop('checked')
    food = @$('#food').prop('checked')
    hot_drinks = @$('#hot_drinks').prop('checked')
    @model.set(
      license: license
      food: food
      hot_drinks: hot_drinks
    )
    @model.save()
    # window.location.reload()
    @hide()

  render: =>
    $(@el).html(@template(@model.toJSON()))
    @$("form").backboneLink(@model)
    @

  open: =>
    @$(".modal").modal('show')

  hide: =>
    @$(".modal").modal('hide')