require 'spec_helper'

module Refinery
  module VoteOptions
    describe VoteOption do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:vote_option)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
