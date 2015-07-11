class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.string :author_id, null:false
      t.timestamps null: false
    end

    add_index(:polls, :author_id)
  end
end
