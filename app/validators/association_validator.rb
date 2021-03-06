class AssociationValidator < ActiveModel::Validator
  attr_reader :record

  def validate(record)
    @record = record

    remove_invalid_messages

    if association_errors.any?
      record.errors.set(association, association_errors)
      record.send(failure_callback) if failure_callback.present?
    end

    association_errors.empty?
  end

  private

  def association_errors
    record.send(association).each_with_object({}) { |associated, errors|
      errors[associated.id] = associated.errors if associated.invalid?
    }
  end

  def association
    options[:association]
  end

  def failure_callback
    options[:fail]
  end

  def remove_invalid_messages
    record.errors[association].clear
  end
end
