class AddAnswersNumberToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :answers_number, :integer
  end
end
