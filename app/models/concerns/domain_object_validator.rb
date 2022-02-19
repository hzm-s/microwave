class DomainObjectValidator < ActiveModel::EachValidator
  def validate_each(model, attribute, value)
    if value.is_a?(DomainObjectConstructionFail)
      message = options[:message] || value.error_message
      model.errors.add(attribute, message)
    end
  end
end
