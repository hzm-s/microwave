class DomainObjectConstructionFail
  def initialize(exception)
    @exception = exception
  end

  def error_message
    @exception.message
  end
end
