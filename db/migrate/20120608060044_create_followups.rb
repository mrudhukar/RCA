class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
      t.belongs_to :team
      t.belongs_to :root_cause

      t.timestamps
    end
  end
end
