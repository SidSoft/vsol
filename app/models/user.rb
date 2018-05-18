class User < ActiveRecord::Base
  attr_accessor :activation_token
  before_save {email.downcase!}
  before_create :create_activation_digest
  validates :name, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :phones, format: {with: VALID_PHONE_REGEX, message: ' in a bad format'}, allow_blank: true
  validates :phone02, format: {with: VALID_PHONE_REGEX, message: ' in a bad format'}, allow_blank: true
  has_secure_password
  validates :password, length: {minimum: 6}, allow_blank: true

  attr_accessor :photo_file

  after_save :save_photo, if: :photo_file

  def save_photo
    filename = photo_file.original_filename
    folder = "public/avatars"

    f = File.open File.join(folder, filename), "wb"
    f.write photo_file.read()
    f.close

    self.photo_file = nil

    update photo: filename

  end

  def User.digest(string)
    cost = 10
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def self.search_name(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.search_email(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.search_phones(search)
    if search
      where('phones LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.search_phone02(search)
    if search
      where('phone02 LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
