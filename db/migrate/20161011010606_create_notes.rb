class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :name, null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
