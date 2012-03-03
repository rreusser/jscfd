class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :functions
      t.text :init
      t.text :iteration

      t.timestamps
    end
  end
end
