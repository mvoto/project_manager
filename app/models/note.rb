class Note < ApplicationRecord
  include SoftDeletable

  # Assocations
  belongs_to :project

  # Validations
  validates :content, presence: true

  # Scopes
  default_scope { where(archived: false).order(created_at: :desc) }
end
