ETahi.Select2Component = Ember.TextField.extend
  tagName: 'div'
  classNames: ['testing-select2']

  autoFocus: false
  source: []
  closeOnSelect: false
  multiSelect: false
  initSelectionData: []
  selectedData: []
  selectionInitialized: false
  removalFlag: false

  setupSelectedListener: ->
    @.$().off 'select2-selecting'
    @.$().on 'select2-selecting', (e) =>
      @sendAction 'selectionSelected', e.choice

  setupRemovedListener: ->
    @.$().off 'select2-removed'
    @.$().on 'select2-removed', (e) =>
      @removalFlag = true
      @sendAction 'selectionRemoved', e.choice

  setSelectedData: (->
    unless @removalFlag
      @initSelectionData = @get('selectedData')
      @.$().select2('val', @get('selectedData').mapProperty('id'))
      @removalFlag = false
  ).observes('selectedData')

  setup:(->
    @setSelectedData()

    options                    = {}
    options.placeholder        = @get('placeholder')
    options.minimumInputLength = @get('minimumInputLength') if @get('minimumInputLength')
    options.formatSelection    = @get('selectedTemplate') if @get('selectedTemplate')
    options.formatResult       = @get('resultsTemplate') if @get('resultsTemplate')
    options.allowClear         = @get('allowClear')
    options.multiple           = @get('multiSelect')
    options.data               = @get('source')
    options.closeOnSelect      = @get('closeOnSelect')
    options.ajax               = @get('remoteSource') if @get('remoteSource')
    options.initSelection      = (el, callback) =>
                                   callback(@initSelectionData)

    @.$().select2(options)
    @setupSelectedListener()
    @setupRemovedListener()
  ).on('didInsertElement')
