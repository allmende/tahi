#= require test_helper

moduleFor 'controller:manuscriptManagerTemplateEdit', 'ManuscriptManagerTemplateEditController',
  setup: ->
    @phase = Ember.Object.create name: 'First Phase'
    @task1 = Ember.Object.create title: 'ATask', isMessage: false, phase: @phase
    @task2 = Ember.Object.create title: 'BTask', isMessage: false, phase: @phase
    @phase.tasks = [@task1, @task2]

    @template = Ember.Object.create
      name: 'A name'
      paper_type: 'A type'
      template:
        phases: [@phase]
    Ember.run =>
      @ctrl = @subject()
      @ctrl.set 'model', @template

test '#rollbackPhase sets the given old name on the given phase', ->
  phase = Ember.Object.create name: "Captain Picard"
  @ctrl.send 'rollbackPhase', phase, "Captain Kirk"
  equal(phase.get('name'), "Captain Kirk")

test '#addPhase adds a phase at a specified index', ->
  @ctrl.send 'addPhase', 0
  equal @ctrl.get('sortedPhases.firstObject.name'), 'New Phase'

test "#removeTask removes the given task from the template's phase", ->
  @ctrl.send 'removeTask', @task1
  tasks = @ctrl.get('sortedPhases.firstObject.tasks')
  deepEqual tasks.mapBy('title'), ['BTask']


