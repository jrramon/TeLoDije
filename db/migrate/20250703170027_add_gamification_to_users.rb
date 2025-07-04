class AddGamificationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :total_correct_predictions, :integer, default: 0, null: false
    add_column :users, :total_predictions, :integer, default: 0, null: false
    add_column :users, :current_streak, :integer, default: 0, null: false
    add_column :users, :best_streak, :integer, default: 0, null: false
    add_column :users, :avatar, :string, default: 'default'
    add_column :users, :title, :string, default: 'Novato'
  end
end
