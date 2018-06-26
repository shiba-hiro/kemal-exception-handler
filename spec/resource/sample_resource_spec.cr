require "../spec_helper"

describe "Sample Resource API" do
  it "Returns response via SampleException handler" do
    get "/v1/sample", headers: HTTP::Headers{"Content-Type" => "application/json"}

    response.status_code.should eq 500
    JSON.parse(response.body)["message"].should eq "Internal Server Error"
    JSON.parse(response.body)["cause"].should eq "SampleException"
  end
end
