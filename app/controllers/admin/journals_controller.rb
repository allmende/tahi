class Admin::JournalsController < ApplicationController
  before_action :authenticate_user!
  before_action :enforce_policy

  respond_to :json

  def index
    journals = current_user.administered_journals
      .includes(manuscript_manager_templates: { phase_templates: { task_templates: :journal_task_type }})

    respond_with journals, each_serializer: AdminJournalSerializer, root: 'admin_journals'
  end

  def show
    respond_to do |f|
      f.json { render json: journal, serializer: AdminJournalSerializer, root: 'admin_journal' }
      f.html { render 'ember/index', layout: 'ember' }
    end
  end

  def authorization
    head 204
  end

  def create
    journal.save!
    respond_with journal, serializer: AdminJournalSerializer, root: 'admin_journal'
  end

  def update
    if journal.update(journal_params)
      render json: journal, serializer: AdminJournalSerializer
    else
      respond_with journal
    end
  end

  def upload_logo
    journal_with_logo = DownloadLogo.call(journal, params[:url])
    render json: journal_with_logo, serializer: AdminJournalSerializer
  end

  def upload_epub_cover
    journal_with_cover = DownloadEpubCover.call(journal, params[:url])
    render json: journal_with_cover, serializer: AdminJournalSerializer
  end

  private

  def journal
    @journal ||= begin
      if params[:id].present?
        Journal.find(params[:id])
      elsif params[:admin_journal].present?
        Journal.new(journal_params)
      end
    end
  end

  def enforce_policy
    authorize_action!(resource: journal)
  end

  def journal_params
    params.require(:admin_journal).permit(
      :description, :doi_journal_prefix,
      :doi_publisher_prefix, :epub_cover,
      :epub_css, :last_doi_issued,
      :manuscript_css, :name,
      :pdf_css
    )
  end
end
