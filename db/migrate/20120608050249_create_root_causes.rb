class CreateRootCauses < ActiveRecord::Migration
  def change
    create_table :root_causes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
