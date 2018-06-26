class SampleException < Exception
  def initialize(message : String, cause : Exception? = nil)
    LOGGER.info "SampleException instance is created."
    super message, cause
  end
end
