class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      
      t.references :member, foreign_key: true
      t.references :trainer, foreign_key: true
      t.references :subject, polymorphic: true
      t.integer :action_type, null: false
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
