class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :text, null: false
      t.boolean :privateer, default: true, null: false
      t.boolean :completed, default: false, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
