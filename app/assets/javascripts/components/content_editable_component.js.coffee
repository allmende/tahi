# modified from: https://github.com/KasperTidemann/ember-contenteditable-view

ETahi.ContentEditableComponent = Em.Component.extend
  attributeBindings: ['contenteditable', 'placeholder']

  editable: true
  userIsTyping: false
  plaintext: false
  preventEnterKey: false

  setup: (->
    @setHTMLFromValue()
    @setPlaceholder() if @elementIsEmpty()
  ).on('didInsertElement')

  # Properties:
  contenteditable: (->
    editable = @get('editable')
    (if editable then 'true' else `undefined`)
  ).property('editable')

  # Observers:
  valueDidChange: (->
    @setHTMLFromValue() if @get('value') and not @get('userIsTyping')
  ).observes('value')

  # DOM Events:
  keyDown: (event) ->
    @set('userIsTyping', true)
    @supressEnterKeyEvent(event) if @get('preventEnterKey')
    @removePlaceholder() if @elementHasPlaceholder()

  keyUp: (event) ->
    if @elementIsEmpty() || @elementHasPlaceholder()
      @set('value', '')
      @setPlaceholder()
      return

    @setValueFromHTML()

  focusOut: ->
    @set 'userIsTyping', false
    @setPlaceholder() if @elementIsEmpty()


  elementIsEmpty: ->
    Em.isEmpty(@.$().text())

  elementHasPlaceholder: ->
    @.$().text() == @get('placeholder')

  setPlaceholder: ->
    @.$().text(@get('placeholder')).addClass('placeholder')

  removePlaceholder: ->
    @.$().text('').removeClass('placeholder')

  setHTMLFromValue: ->
    @.$().html(@get('value'))

  setValueFromHTML: ->
    if @get('plaintext')
      @set 'value', @.$().text()
    else
      @set 'value', @.$().html()

  supressEnterKeyEvent: (e) ->
    if e.keyCode == 13 || e.which == 13
      e.preventDefault()