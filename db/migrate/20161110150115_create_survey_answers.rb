class CreateSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_answers do |t|
      t.references :filled_survey, foreign_key: true
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
