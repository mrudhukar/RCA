class CreateRootCauseBugs < ActiveRecord::Migration
  def change
    create_table :root_cause_bugs do |t|
      t.belongs_to :root_cause
      t.belongs_to :bug

      t.timestamps
    end

    add_index :root_cause_bugs, [:root_cause_id, :bug_id]
  end
end
