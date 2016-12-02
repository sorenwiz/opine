require 'spec_helper'

module Refinery
  module Polls
    describe Poll do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:poll,
          :slug => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:slug) { should == "Refinery CMS" }
      end
    end
  end
end
