class AddTeamIdToRc < ActiveRecord::Migration
  def change
    add_column :root_causes, :team_id, :integer

    RootCause.all.each do |rc|
      teams = rc.bugs.collect(&:team).uniq
      if teams.size > 1
        raise
      else
        rc.team = teams[0]
        rc.save!
      end
    end

    remove_column :followups, :team_id
  end
end
