class AddLabelsStoriesToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :label, :string, default: "rca"
    add_column :teams, :story_type, :string, default: "bug, chore, feature"
  end
end
