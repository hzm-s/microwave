class DomainObjectValidator < ActiveModel::EachValidator
  def validate_each(model, attribute, value)
    if value.is_a?(DomainObjectConstructionFail)
      message = options[:message] || I18n.t(value.i18n_key, scope: [:domain_objects, :errors])
      model.errors.add(attribute, message)
    end
  end
end
