ETahi.PhaseHeaderView = Em.View.extend
  templateName: 'phase_header'
  classNames: ['column-header']
  classNameBindings: ['active']
  active: false

  focusIn: (e)->
    @set('active', true)

  keyUp: (e)->
    Tahi.utils.resizeColumnHeaders()

  actions:
    save: ->
      @set('active', false)
      name = @$('h2').get(0).innerText
      phase = @get('phase')

      if phase.get('name') != name
        phase.set('name', name)
        phase.save()

    cancel: ->
      @set('active', false)
      @get('phase').rollback()