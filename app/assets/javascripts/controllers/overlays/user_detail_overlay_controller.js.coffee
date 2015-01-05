ETahi.UserDetailOverlayController = Ember.ObjectController.extend ETahi.FormErrorsMixin,
  overlayClass: 'overlay--fullscreen user-detail-overlay'
  resetPasswordSuccess: false
  resetPasswordFailure: false

  actions:
    saveUser: ->
      @get('model').save()
                   .then =>
                     @clearFormErrors()
                     @send('closeOverlay')
                   .catch (response) =>
                     @displayFormErrorsFromResponse response

    rollbackUser: ->
      @get('model').rollback()
      @clearFormErrors()
      @send('closeOverlay')

    resetPassword: (user) ->
      $.get "/admin/journal_users/#{user.get('id')}/reset"
      .done => @set 'resetPasswordSuccess', true
      .fail => @set 'resetPasswordFailure', true
