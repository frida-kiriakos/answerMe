class CreateFilledSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :filled_surveys do |t|
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
