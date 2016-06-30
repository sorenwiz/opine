# == Schema Information
#
# Table name: polls
#
#  id                            :integer          not null, primary key
#  heading                       :string(255)
#  sub_heading                   :string(255)
#  teaser                        :text(65535)
#  description_heading           :string(255)
#  description                   :text(65535)
#  expires_at                    :date
#  user_id                       :integer
#  order                         :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  slug                          :string(255)
#  category_id                   :integer
#  image_file_name               :string(255)
#  image_content_type            :string(255)
#  image_file_size               :integer
#  image_updated_at              :datetime
#  background_image_file_name    :string(255)
#  background_image_content_type :string(255)
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  wallpaper_file_name           :string(255)
#  wallpaper_content_type        :string(255)
#  wallpaper_file_size           :integer
#  wallpaper_updated_at          :datetime
#  question                      :string(255)
#

class Poll < ActiveRecord::Base
  extend FriendlyId
  friendly_id :heading, use: [:slugged, :finders]

  has_many :vote_options, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :category

  has_attached_file :image, styles: {medium: "368x260#"}
  has_attached_file :background_image, styles: {medium: "740x380#"}
  has_attached_file :wallpaper, styles: {big: "1920x2000#"}

  accepts_nested_attributes_for :vote_options, allow_destroy: true

  validates_presence_of :description, :teaser, :heading, :description_heading, :expires_at
  validates_attachment :image, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}, presence: true
  validates_attachment :background_image, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}, presence: true

  scope :active, -> { where('expires_at >= ?', Date.today) }
end
