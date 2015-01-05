ETahi.FormErrorsMixin = Em.Mixin.create
  _init: (->
    @clearFormErrors()
  ).on('init')

  formErrors: null

  displayFormError: (key, value) ->
    @set('formErrors.' + key, (if Ember.isArray(value) then value.join(', ') else value))

  displayFormErrorsFromResponse: (response) ->
    self = @

    (for own key, value of Tahi.utils.camelizeKeys(response.errors)
      self.displayFormError key, value
    )

  clearFormErrors: ->
    @set 'formErrors', {}
