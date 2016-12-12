# == Schema Information
#
# Table name: authentications
#
#  id           :integer          not null, primary key
#  provider     :string
#  uid          :string
#  token        :string
#  token_secret :string
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
