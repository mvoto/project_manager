class Note < ApplicationRecord
  # Assocations
  belongs_to :project

  # Validations
  validates :content, presence: true
end
