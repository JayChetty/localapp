class Localapp.Models.CurrentOwner extends Backbone.Model


class Localapp.Collections.CurrentOwners extends Backbone.Collection
  model: Localapp.Models.CurrentOwner
  url: "/current_owners"