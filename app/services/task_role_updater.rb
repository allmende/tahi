class TaskRoleUpdater
  attr_accessor :task, :paper, :user, :paper_role_name

  def initialize(task, user_id, paper_role_name)
    @task = task
    @paper = task.paper
    @user = User.find(user_id)
    @paper_role_name = paper_role_name
  end

  def update
    paper.transaction do
      paper.assign_role!(user, paper_role_name)
      related_tasks.each do |task|
        ParticipationFactory.create(task, user)
      end
    end
  end

  private

  def related_tasks
    paper.tasks.for_role(paper_role_name).incomplete
  end
end
