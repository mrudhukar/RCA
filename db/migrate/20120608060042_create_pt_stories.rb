class CreatePtStories < ActiveRecord::Migration
  def change
    create_table :pt_stories do |t|
      t.integer :pt_id
      t.string  :title
      t.text    :description 
      t.belongs_to :bug
      t.belongs_to :followup

      t.timestamps
    end
  end
end
