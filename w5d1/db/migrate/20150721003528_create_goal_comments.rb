class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
