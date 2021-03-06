module StandardTasks
  class PaperReviewerTaskSerializer < ::TaskSerializer
    embed :ids
    has_many :reviewers, serializer: UserSerializer, include: true, root: :users

    def reviewers
      object.paper.reviewers.includes(:affiliations)
    end
  end
end
