moduleForComponent 'flow-column', 'Unit: components/flow-column',
  needs: [
    'component:segmented-button'
    'component:progress-spinner'
    'component:flow-task-group'
    'component:select-2-single'
  ]

appendBasicComponent = (context, attrs) ->
  Ember.run =>
    context.component = context.subject()
    context.component.setProperties(attrs)
  context.append()

test "clicking the X should send 'removeFlow'", ->
  targetObject =
    externalAction: (flow) ->
      ok true
  componentAttrs =
    removeFlow: 'externalAction'
    targetObject: targetObject
    flow: Ember.Object.create title: "Fake Title"

  appendBasicComponent(this, componentAttrs)
  click '.remove-column'

test 'it forwards viewCard', ->
  targetObject =
    externalAction: (card) ->
      equal card, "test"
  componentAttrs =
    viewCard: 'externalAction'
    targetObject: targetObject

  component = ETahi.FlowColumnComponent.create(componentAttrs)
  component.send 'viewCard', 'test'
