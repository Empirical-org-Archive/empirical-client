require 'spec_helper'

describe Empirical::Client::Endpoints::ActivitySession do

  let!(:uid) { 'wQrdU5nonDcjB222rYmwyQ' }
  let(:activity) { Empirical::Client::Endpoints::ActivitySession }
  let(:finder) { VCR.use_cassette('activity_session_get') { activity.find(uid) } }
  # let(:finder) { activity.find(uid) }

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
      expect(finder.activity_session).to be_kind_of(Hashie::Mash)
    end

    it "should be the activity expected" do
      expect(finder.activity_session.uid).to eq(uid)
    end

    it "should have the activity session merge as expected" do
      expect(finder.activity_session.uid).to eq(uid)
    end
  end
end
