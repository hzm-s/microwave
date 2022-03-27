module I18nSupport
  def t_model_error(model, attribute, key, **extra)
    scope = "activerecord.errors.models.#{model}.attributes.#{attribute}"
    options = extra.merge(scope: scope)
    I18n.t(key, **options)
  end
end

RSpec.configure do |c|
  c.include I18nSupport
end
