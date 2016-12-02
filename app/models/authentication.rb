# == Schema Information
#
# Table name: authentications
#
#  id           :integer          not null, primary key
#  user_id      :string
#  provider     :string
#  uid          :string
#  token        :string
#  token_secret :string
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
