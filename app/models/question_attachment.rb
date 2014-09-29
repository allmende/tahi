class QuestionAttachment < ActiveRecord::Base
  include EventStreamNotifier

  belongs_to :question

  mount_uploader :attachment, QuestionAttachmentUploader

  def notifier_payload
    { paper_id: question.task.paper.id }
  end
end
