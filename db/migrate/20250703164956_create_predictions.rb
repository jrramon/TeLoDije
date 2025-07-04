class CreatePredictions < ActiveRecord::Migration[7.1]
  def change
    create_table :predictions do |t|
      t.string :title, null: false
      t.text :question, null: false
      t.datetime :resolution_date, null: false
      t.string :source
      t.text :hint
      t.boolean :resolved, default: false, null: false
      t.boolean :outcome
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
