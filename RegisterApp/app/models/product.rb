class Product < ApplicationRecord
  validates :lookupCode, presence: true, uniqueness: true

  before_validation :lowerCase, on: :create

  private

  def lowerCase
    self.lookupCode = lookupCode.downcase
  end
end
