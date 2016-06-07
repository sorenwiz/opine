# == Schema Information
#
# Table name: polls
#
#  id                  :integer          not null, primary key
#  heading             :string(255)
#  sub_heading         :string(255)
#  teaser              :text(65535)
#  description_heading :string(255)
#  description         :text(65535)
#  expires_at          :datetime
#  user_id             :integer
#  order               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  slug                :string(255)
#

class Poll < ActiveRecord::Base
  extend FriendlyId
  friendly_id :heading, use: [:slugged, :finders]

  has_many :vote_options, dependent: :destroy

  accepts_nested_attributes_for :vote_options, allow_destroy: true

  validates_presence_of :description, :teaser, :heading, :description_heading

end
