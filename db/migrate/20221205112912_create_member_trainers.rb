class CreateMemberTrainers < ActiveRecord::Migration[6.1]
  def change
    create_table :member_trainers do |t|
      t.references :member, null: false, foreign_key: true
      t.references :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
