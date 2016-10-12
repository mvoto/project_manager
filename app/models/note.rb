class Note < ApplicationRecord
  include SoftDeletable

  # Assocations
  belongs_to :project

  # Validations
  validates :content, presence: true

  # Scopes
  default_scope { where(archived: false).order(created_at: :desc) }

  # Callbacks
  before_save :update_project_state, if: :update_project_via_content?

  private
  attr_reader :match_phrase

  def update_project_via_content?
    states = Project::STATES.collect{|state| "mark as #{state}" }.join("|")
    @match_phrase = content.match(/(#{states})/)
    match_phrase.present?
  end

  def update_project_state
    project.state = match_phrase[0].split(' ').last
    project.save
  end
end
