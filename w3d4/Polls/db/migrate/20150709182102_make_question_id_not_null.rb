class MakeQuestionIdNotNull < ActiveRecord::Migration
  def change
    change_column :answer_choices, :question_id, :integer, null: false
  end
end
