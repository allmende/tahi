class QuestionAttachmentsPolicy < ApplicationPolicy
  primary_resource :question_attachment

  include TaskAccessCriteria

  def connected_users
    tasks_policy.connected_users
  end

  def show?
    authorized_to_modify_task?
  end

  def destroy?
    authorized_to_modify_task?
  end

  private

  def task
    question_attachment.question.task
  end

  def tasks_policy
    @tasks_policy ||= TasksPolicy.new(current_user: current_user, resource: task)
  end
end
