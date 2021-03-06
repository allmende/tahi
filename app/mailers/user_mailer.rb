class UserMailer < ActionMailer::Base
  include MailerHelper
  default from: ENV.fetch('FROM_EMAIL')

  after_action :prevent_delivery_to_invalid_recipient

  def add_collaborator(invitor_id, invitee_id, paper_id)
    @paper = Paper.find(paper_id)
    invitor = User.find_by(id: invitor_id)
    invitee = User.find_by(id: invitee_id)
    @invitor_name = display_name(invitor)
    @invitee_name = display_name(invitee)

    mail(
      to: invitee.try(:email),
      subject: "You've been added as a collaborator to a paper on Tahi")
  end

  def add_participant(invitor_id, invitee_id, task_id)
    @task = Task.find(task_id)
    invitor = User.find_by(id: invitor_id)
    invitee = User.find_by(id: invitee_id)
    @invitor_name = display_name(invitor)
    @invitee_name = display_name(invitee)

    mail(
      to: invitee.try(:email),
      subject: "You've been added to a conversation on Tahi")
  end

  def add_reviewer(reviewer_id, paper_id)
    @paper = Paper.find(paper_id)
    user = User.find(reviewer_id)
    @reviewer_name = display_name(user)

    mail(
      to: user.try(:email),
      subject: "You've been added as a reviewer on Tahi")
  end

  def assigned_editor(editor_id, paper_id)
    @paper = Paper.find(paper_id)
    user = User.find(editor_id)
    @editor_name = display_name(user)

    mail(
      to: user.try(:email),
      subject: "You've been assigned as an editor on Tahi")
  end

  def mention_collaborator(comment_id, commentee_id)
    @comment = Comment.find(comment_id)
    @commenter = @comment.commenter
    @commentee = User.find(commentee_id)

    mail(
      to: @commentee.try(:email),
      subject: "You've been mentioned on Tahi")
  end
end
