class AddQuestionIdToAnswerChoice < ActiveRecord::Migration
  def change
    add_column(:answer_choices, :question_id, :integer)
    add_index(:answer_choices, :question_id)
  end
end
