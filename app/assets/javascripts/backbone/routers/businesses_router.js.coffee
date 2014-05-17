class Localapp.Routers.BusinessesRouter extends Backbone.Router
  initialize:(options) =>
    console.log('init')

  routes:
    ".*"        : "index"

  index: ->
    console.log('index')
    console.log($('#map')[0])
    view = new Localapp.Views.BusinessesView()
    $('.businesses').html(view.render().el)
