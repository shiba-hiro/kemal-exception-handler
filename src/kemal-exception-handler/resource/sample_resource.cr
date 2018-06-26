get "/v1/sample" do |env|
  LOGGER.info "GET /v1/sample is called."
  raise SampleException.new "Operation rejected!!"
end
