require 'spec_helper'

describe Empirical::Client::Endpoints::Activities do

  let!(:uid) { 'BaJi4-PhNRz9um-o0u-w6Q' }


  context "#find" do

    let(:activity) { Empirical::Client::Endpoints::Activities.new }

    it "should make an api request" do
      expect(activity.find(uid)).to be_true
    end
  end
end