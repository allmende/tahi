window.Tahi ||= {}

class Tahi.RichEditableElement
  constructor: (@element) ->
    @instance = CKEDITOR.inline @element,
      extraPlugins: 'sharedspace'
      removePlugins: 'floatingspace,resize'
      sharedSpaces:
        top: 'toolbar'
      toolbar: [
        [ 'Styles', 'Format', 'FontSize' ]
        [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ]
        [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote', 'Table' ]
        [ 'PasteFromWord' ],
        [ 'Link', 'Unlink', 'Anchor' ]
        [ 'Find', 'Replace', '-', 'Scayt' ]
      ]

    @placeholderText = @element.attributes['placeholder'].value
    @setPlaceholder()
    @instance.on 'focus', => @clearPlaceholder()
    @instance.on 'blur', => @setPlaceholder()

  setPlaceholder: ->
    text = $($.parseHTML(@instance.getData())).text().trim()
    if text == '' || text == @placeholderText
      @instance.element.addClass 'placeholder'
      @instance.setData @placeholderText

  clearPlaceholder: ->
    text = $($.parseHTML(@instance.getData())).text().trim()
    if text == @placeholderText
      @instance.element.removeClass 'placeholder'
      @instance.setData ''
