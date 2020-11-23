class Company < ApplicationRecord
  EMAIL_REGEX = /\b[A-Z0-9a-z._%+-]+@getmainstreet.com\z/
  EMAIL_REGEX_MESSAGE = "email should be getmainstreet.com domain"

  has_rich_text :description

  validates :email, format: { with: EMAIL_REGEX, message: EMAIL_REGEX_MESSAGE }

  before_save :validate_city_and_state?

  def validate_city_and_state?
    zip_code_hash = ZipCodes.identify(zip_code)

    self.city = zip_code_hash&.dig(:city)
    self.state = zip_code_hash&.dig(:state_name)
  end
end
