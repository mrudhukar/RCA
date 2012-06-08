class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.belongs_to :team
      t.string  :title
      t.text    :description
      t.integer :pt_id

      t.date :conducted_at

      t.timestamps
    end
  end
end
