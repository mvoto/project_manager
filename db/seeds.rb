ActiveRecord::Base.transaction do
  client = Client.find_or_create_by(name: 'Top Client')

  (1..30).each do |number|
    project = Project.find_or_create_by(
      name: "Awesome Project: ##{number}",
      client: client,
      conclusion_date: DateTime.parse('2016/10/13') + 3.years
    )

    (1..3).each do |n|
      Note.find_or_create_by(
        project: project,
        content: "#{n.ordinalize} #{project.name}'s Note"
      )
    end
  end
end
