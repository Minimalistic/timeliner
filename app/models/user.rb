class User < ActiveRecord::Base
  extend FriendlyId
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :milestones, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true

  has_many :social_media_links, dependent: :destroy
  accepts_nested_attributes_for :social_media_links, allow_destroy: true

  friendly_id :username, use: :slugged

  validates :username,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[a-z0-9][-a-z0-9]{1,19}\Z/i,
              message: "can't contain any special characters"
            }
  validates :blog_url,
            format: {
              with: URI.regexp(['http', 'https']),
              message: 'format match http://link.com'
            },
            allow_blank: true
end
