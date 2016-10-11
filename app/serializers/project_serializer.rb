class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :conclusion_date
  belongs_to :client
  has_many :notes
end
