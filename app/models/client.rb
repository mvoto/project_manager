class Client < ApplicationRecord
  # Associations
  has_many :projects

  # Validations
  validates :name, presence: true
end
