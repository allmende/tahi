ETahi.TaskRoute = Ember.Route.extend
  model: (params) ->
    @store.find('paper', params.paper_id).then =>
      @store.find('task', params.task_id)

  afterModel: (model) ->
    return unless model.get('type') == "AuthorsTask"
    Ember.$.getJSON '/affiliations', (data)->
      model.set('institutions', data.institutions)

  setupController: (controller, model) ->
    # FIXME: Rename AdHocTask to Task (here, in views, and in templates)
    currentType = model.get('type')
    currentType = 'AdHocTask' if currentType == 'Task'
    baseObjectName = (currentType || 'AdHocTask').replace('Task', 'Overlay')
    @set('baseObjectName', baseObjectName)

    taskController = @controllerFor(baseObjectName)
    taskController.set('model', model)
    @set('taskController', taskController)

    if !Em.isEmpty(@controllerFor('application').get('overlayRedirect'))
      taskController.set('onClose', 'redirect')

  renderTemplate: ->
    @render @get('baseObjectName'),
      into: 'application'
      outlet: 'overlay'
      controller: @get('taskController')
    @render(@controllerFor('application').get('overlayBackground'))

  deactivate: ->
    @send('closeOverlay')
    @controllerFor('application').setProperties(overlayRedirect: [], overlayBackground: null)

  actions:
    willTransition: (transition) ->
      redirectStack = @controllerFor('application').get('overlayRedirect')
      if !Em.isEmpty(redirectStack)
        redirectRoute = redirectStack.popObject()
        unless transition.targetName == redirectRoute.get('firstObject')
          @controllerFor('application').set('cachedModel', null)
