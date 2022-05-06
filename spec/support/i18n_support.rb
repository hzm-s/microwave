module I18nSupport
  def t_model_error(model, attribute, key, **extra)
    scope = "activerecord.errors.models.#{model}.attributes.#{attribute}"
    options = extra.merge(scope: scope)
    I18n.t(key, **options)
  end

  def t_model_attr_error(model, attribute, key, **extra)
    message = t_model_error(model, attribute, key, **extra)
    model.to_s.camelize.constantize.human_attribute_name(attribute) + message
  end
end

RSpec.configure do |c|
  c.include I18nSupport
end
