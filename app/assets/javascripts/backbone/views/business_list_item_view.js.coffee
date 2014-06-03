class Localapp.Views.BusinessListItemView extends Backbone.View
  template: JST["backbone/templates/business_list_item"]
  tagName: "li" 
  className: "business-list-item" 

  render: =>
    $(@el).html(@template(@options.marker))
    @