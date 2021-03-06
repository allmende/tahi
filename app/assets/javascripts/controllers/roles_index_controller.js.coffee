ETahi.RolesIndexController = Ember.ArrayController.extend
  needs: ['journal']
  journal: Ember.computed.alias('controllers.journal.model')

  actions:
    addRole: ->
      role = @store.createRecord('role')
      @get('content').unshiftObject(role)
    deleteRole: (role) ->
      # FIXME: rollback if there was an error deleting a role
      role.destroyRecord()
