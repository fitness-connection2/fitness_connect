class AddIntroductionToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :introduction, :text
  end
end
