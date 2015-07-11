class MakePollIdNotNull < ActiveRecord::Migration
  def change
    change_column(:questions, :poll_id, :integer, :null => false)
    add_index(:questions, :poll_id)
  end
end
