class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :client, foreign_key: true
      t.string :state, default: "started"
      t.datetime :conclusion_date, null: false

      t.timestamps
    end
  end
end
