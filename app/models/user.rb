class User < ActiveRecord::Base
  extend FriendlyId
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :milestones, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true

  has_many :social_media_links, dependent: :destroy
  accepts_nested_attributes_for :social_media_links, allow_destroy: true

  after_destroy :send_goodbye_email

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
              message: 'format should match http://link.com'
            },
            allow_blank: true

  def full_name
    format('%s %s', first_name, last_name)
  end

  def available_with_message?
    available && availability_message.present?
  end

  def basic_info?
    first_name.present? && last_name.present? && description.present? && bio.present?
  end

  def after_confirmation
    send_welcome_email
  end

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_now
  end

  def send_goodbye_email
    GoodbyeMailer.goodbye_email(self).deliver_now
  end

  def send_message(sender_email, message_subject, message_body)
    ContactMailer.contact_form_email(self, sender_email, message_subject, @message_body).deliver_now
  end

  def increase_message_counter
    update(message_counter: message_counter + 1)
  end
end
