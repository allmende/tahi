ETahi.FlowManagerRoute = ETahi.AuthorizedRoute.extend
  beforeModel: (transition) ->
    @handleUnauthorizedRequest(transition) unless @getCurrentUser?

  model: ->
    if cachedModel =  @controllerFor('application').get('cachedModel')
      @controllerFor('application').set('cachedModel' , null)
      cachedModel
    else
      @store.find('userFlow')

  afterModel: ->
    @store.find('commentLook')

  setupController: (controller, model) ->
    controller.set('model', model)
    controller.set('commentLooks', @store.all('commentLook'))
    controller.set('journalTaskTypes', @store.all('journalTaskType'))

  actions:
    chooseNewFlowManagerColumn: ->
      controller = @controllerFor('chooseNewFlowManagerColumnOverlay')
      controller.set 'isLoading', true

      ETahi.RESTless.get('/user_flows/potential_flows').then (data) ->
        controller.set 'isLoading', false
        controller.set('flows' , data.flows)

      @render('chooseNewFlowManagerColumnOverlay',
        into: 'application'
        outlet: 'overlay'
        controller: controller)

    removeFlow: (flow) ->
      flow.destroyRecord()

    saveFlow: (flow) ->
      flow.save()

    viewCard: (task) ->
      paperId = task.get('litePaper.id')
      redirectParams = ['flow_manager']
      @controllerFor('application').get('overlayRedirect').pushObject(redirectParams)
      @controllerFor('application').set('cachedModel' , @modelFor('flow_manager'))
      @controllerFor('application').set('overlayBackground', 'flow_manager')
      @transitionTo('task', paperId, task.get('id'))
