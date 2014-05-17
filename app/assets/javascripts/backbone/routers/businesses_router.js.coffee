class Localapp.Routers.BusinessesRouter extends Backbone.Router
  initialize:(options) =>

  routes:
    ".*"        : "index"

  index: ->
    view = new Localapp.Views.BusinessesView()
    view.render()
