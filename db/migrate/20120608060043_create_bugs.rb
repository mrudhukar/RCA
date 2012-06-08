class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.belongs_to :team

      t.timestamps
    end
  end
end
