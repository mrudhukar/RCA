class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
      t.belongs_to :team
      t.belongs_to :root_cause
      t.string  :title
      t.text    :description
      t.integer :pt_id

      t.integer :status, :default => Followup::Status::NOT_STARTED

      t.timestamps
    end
  end
end
