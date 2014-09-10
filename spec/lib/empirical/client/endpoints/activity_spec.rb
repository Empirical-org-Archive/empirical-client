require 'spec_helper'

describe Empirical::Client::Endpoints::Activity do

  let!(:uid) { 'BaJi4-PhNRz9um-o0u-w6Q' }
  let(:activity) { Empirical::Client::Endpoints::Activity }
  let(:finder) { VCR.use_cassette('activity_get') { activity.find(uid) } }

  context "base" do
    it "should be a hashie" do
      expect(activity.new).to be_kind_of(Hashie::Mash)
    end
  end

  context "#find" do

    it "should return metadata" do
      expect(finder.meta).to be_kind_of(Hashie::Mash)
    end

    it "should have a successful status" do
      expect(finder.meta.status).to eq("success")
    end

    it "should return an activity" do
      expect(finder.activity).to be_kind_of(Hashie::Mash)
    end

    it "should be the activity expected" do
      expect(finder.activity.uid).to eq(uid)
    end
  end
end
