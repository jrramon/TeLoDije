class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :message, null: false
      t.boolean :read, default: false, null: false
      t.string :notification_type, null: false
      t.integer :reference_id
      t.string :reference_type

      t.timestamps
    end
    
    add_index :notifications, [:user_id, :read]
    add_index :notifications, [:reference_type, :reference_id]
  end
end
