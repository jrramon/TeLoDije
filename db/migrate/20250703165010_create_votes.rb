class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :prediction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :outcome, null: false
      t.integer :points, null: false

      t.timestamps
    end
  end
end
