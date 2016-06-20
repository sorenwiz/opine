# == Schema Information
#
# Table name: votes
#
#  id             :integer          not null, primary key
#  poll_id        :integer
#  user_id        :integer
#  vote_option_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  belongs_to :vote_option

  validates_presence_of :user, :poll, :vote_option
  validates_uniqueness_of :user_id, scope: :poll_id
end
