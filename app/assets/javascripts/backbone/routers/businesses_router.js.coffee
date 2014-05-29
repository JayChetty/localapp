class Localapp.Routers.BusinessesRouter extends Backbone.Router

  routes:
    ".*"        : "index"

  index: ->
    view = new Localapp.Views.BusinessesView()
    $('#businesses').html(view.render().el)
    view.renderMapAndList()
