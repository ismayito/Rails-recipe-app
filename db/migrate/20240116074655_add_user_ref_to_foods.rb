class AddUserRefToFoods < ActiveRecord::Migration[7.1]
  def change
    remove_column :foods,:user_id
    add_reference :foods, :user, null: false, foreign_key: true
  end
end
