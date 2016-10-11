class Note < ApplicationRecord
  # Assocations
  belongs_to :project

  # Validations
  validates :name, presence: true
end
