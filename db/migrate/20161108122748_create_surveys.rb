class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.text :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
