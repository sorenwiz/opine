# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :omniauthable

  has_many :authentications

  def self.find_for_oauth(auth, signed_in_resource=nil)
    #User and auth exist
    user = User.includes(:authentications).where(authentications: {provider: auth.provider, uid: auth.uid}).first
    return user if user
    #user exist, but new auth type
    if (registered_user = User.where(email: auth.info.email).first)
      registered_user.authentications.create({provider: auth.provider, uid: auth.uid})
      registered_user.touch
      return registered_user
    end

    #user doesn't exist
    pw = Devise.friendly_token[0, 20]
    user = User.new(name: auth.info.name,
                    email: auth.info.email,
                    password: pw,
                    password_confirmation: pw,
    )
    user.save!
    user.authentications.create({provider: auth.provider, uid: auth.uid})
    return user
  end

  def facebook_id
    authentications.last.uid
  end
end
