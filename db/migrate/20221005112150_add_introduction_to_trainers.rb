class AddIntroductionToTrainers < ActiveRecord::Migration[6.1]
  def change
    add_column :trainers, :introduction, :text
  end
end
