require 'spec_helper'

describe Empirical::Client::Endpoint do

  let(:endpoint) { Empirical::Client::Endpoint.new }

  context "base" do
    it "should be a hashie" do
      expect(endpoint).to be_kind_of(Hashie::Mash)
    end

    it "should refer to the api path" do
      expect(endpoint.api_base).to match(/api\/v1$/)
    end
  end

  context "#request" do

    context "with a working API" do


      it "should handle a successful data response" do
        VCR.use_cassette('activity_get') do
          req = endpoint.request(:get, "activities/BaJi4-PhNRz9um-o0u-w6Q")
        end

        expect(endpoint.meta.status).to eq("success")
      end

      it "should handle a missing record" do
        expect {
          VCR.use_cassette('activity_get_bad_uid') do
            endpoint.request(:get, "activities/abc-def")
          end
        }.to raise_error(Empirical::Client::EndpointException, "Missing Record")
      end

    end


    it "should handle a failed connection" do
      endpoint.api_base = "http://localhost:80808/api/not/here"

      expect {
        endpoint.request(:get, "activities/BaJi4-PhNRz9um-o0u-w6Q")
      }.to raise_error(Empirical::Client::ApiException)

    end
  end
end
