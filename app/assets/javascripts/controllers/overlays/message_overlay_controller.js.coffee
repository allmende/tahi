ETahi.MessageOverlayController = ETahi.TaskController.extend ETahi.ControllerParticipants,
  newCommentBody: ""

  message: true

  _clearNewMessage: ->
    @set('newCommentBody', "")

  actions:
    clearMessageContent: ->
      @_clearNewMessage()

    postComment: ->
      userId = Tahi.currentUser.id.toString()
      commenter = @store.all('user').findBy('id', userId)
      commentFields =
        commenter: commenter
        messageTask: @get('model')
        body: @get('newCommentBody')
      newComment = @store.createRecord('comment', commentFields)
      newComment.save().then(@_clearNewMessage.bind(@), newComment.deleteRecord)