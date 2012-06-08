class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string  :title
      t.integer :project_id
      t.string  :token

      t.timestamps
    end

    Team.create!(:title => "Apollo", :project_id => "24159", :token => '74058e3ea314d1469b9c070371f02bc6')
  end
end
