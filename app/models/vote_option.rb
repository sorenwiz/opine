# == Schema Information
#
# Table name: vote_options
#
#  id         :integer          not null, primary key
#  text       :string
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VoteOption < ActiveRecord::Base
  belongs_to :poll
end
