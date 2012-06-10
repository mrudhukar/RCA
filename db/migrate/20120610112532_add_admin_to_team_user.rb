class AddAdminToTeamUser < ActiveRecord::Migration
  def change
    add_column :team_users, :admin, :boolean, :default => false
  end
end
