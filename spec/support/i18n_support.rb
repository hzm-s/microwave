module I18nSupport
  def t_model_error(model, attribute, key)
    scope = "activerecord.errors.models.#{model}.attributes.#{attribute}"
    I18n.t(key, scope: scope)
  end
end

RSpec.configure do |c|
  c.include I18nSupport
end
