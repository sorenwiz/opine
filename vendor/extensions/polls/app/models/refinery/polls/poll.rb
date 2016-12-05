module Refinery
  module Polls
    class Poll < Refinery::Core::BaseModel
      self.table_name = 'refinery_polls'


      translates :heading, :sub_heading, :teaser, :description_heading, :description, :question, :slug

      validates :heading, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'

      belongs_to :background_image, :class_name => '::Refinery::Image'

      belongs_to :wallpaper, :class_name => '::Refinery::Image'

      has_many :vote_options, :class_name => '::Refinery::VoteOptions::VoteOption'
      accepts_nested_attributes_for :vote_options, allow_destroy: true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
