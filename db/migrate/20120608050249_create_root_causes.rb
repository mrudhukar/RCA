class CreateRootCauses < ActiveRecord::Migration
  def change
    create_table :root_causes do |t|
      t.string :title
      t.text :description
      t.integer :root_cause_bugs_count

      t.timestamps
    end
  end
end
