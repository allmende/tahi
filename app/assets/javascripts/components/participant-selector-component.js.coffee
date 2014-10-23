ETahi.ParticipantSelectorComponent = Ember.Component.extend
  availableParticipantsList: []

  resultsTemplate: (user) ->
    '<strong>' + user.full_name + '</strong><br><div class="tt-suggestion-sub-value">' + user.info + '</div>'

  selectedTemplate: (user) =>
    name = (user.full_name || user.get('fullName'))
    url  = (user.avatar_url || user.get('avatarUrl'))
    new Handlebars.SafeString "<img alt='#{name}' class='user-thumbnail' src='#{url}' data-toggle='tooltip' title='#{name}'/>"

  remoteSource: (->
    url: "/filtered_users/non_participants/#{@get('taskId')}/"
    dataType: "json"
    data: (term) ->
      query: term
    results: (data) ->
      results: data
  ).property()

  availableParticipants: (->
    return [] if @get('everyone.isPending')
    @get('currentParticipants')
  ).property('everyone.content.[]', 'currentParticipants.@each')

  updateParticipantsList: (->
    Ember.run =>
      @set('availableParticipantsList', @get('availableParticipants'))
  ).observes('availableParticipants').on('init')

  actions:
    addParticipant: (newParticipant) ->
      @sendAction("onSelect", newParticipant.id)
    removeParticipant: (participant) ->
      @sendAction("onRemove", participant.id)
