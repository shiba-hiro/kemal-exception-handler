exception SampleException do |env, ex|
  LOGGER.info "SampleException is mapped."
  LOGGER.error ex.inspect_with_backtrace
  env.response.content_type = "application/json"
  halt env, status_code: 500, response: Hash{"message" => "Internal Server Error", "cause" => "SampleException"}.to_json
end
