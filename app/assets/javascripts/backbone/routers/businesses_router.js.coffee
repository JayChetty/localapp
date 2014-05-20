class Localapp.Routers.BusinessesRouter extends Backbone.Router

  routes:
    ".*"        : "index"

  index: ->
    view = new Localapp.Views.BusinessesView()
    view.render()
