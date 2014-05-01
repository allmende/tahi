class ChooseCardTypeOverlay < CardOverlay
  def self.launch(session)
    new session.find('.overlay')
  end

  def task_type=(task_type)
    find('.task-type-select')
    select_from_chosen(task_type, class: 'task-type-select')
  end

  def create(params)
    self.task_type = params[:card_type]
    find('.primary-button', text: 'ADD').click
    self
  end
end
