class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :survey, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
