class AddCategoryToPredictions < ActiveRecord::Migration[7.1]
  def change
    add_reference :predictions, :category, null: true, foreign_key: true
  end
end
