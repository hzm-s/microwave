class DomainObjectConstructionFail
  def initialize(exception)
    @exception = exception
  end

  def i18n_key
    @exception.message
  end
end
