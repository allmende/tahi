module StandardTasks
  class ReportingGuidelinesTaskSerializer < ::TaskSerializer
    has_many :questions, embed: :ids, include: true
  end
end
