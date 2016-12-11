module Refinery
  module VoteOptions
    class VoteOption < Refinery::Core::BaseModel
      self.table_name = 'refinery_vote_options'

      belongs_to :poll, class_name: 'Refinery::Polls::Poll'
      translates :text, :alias

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
