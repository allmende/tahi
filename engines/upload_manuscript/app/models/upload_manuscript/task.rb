module UploadManuscript
  class Task < ::Task
    include ::MetadataTask

    title "Upload Manuscript"
    role "author"

    def assignees
      User.none
    end

    def active_model_serializer
      UploadManuscript::TaskSerializer
    end
  end
end
