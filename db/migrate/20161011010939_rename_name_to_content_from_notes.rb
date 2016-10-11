class RenameNameToContentFromNotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :notes, :name, :string
    add_column :notes, :content, :text
  end
end
