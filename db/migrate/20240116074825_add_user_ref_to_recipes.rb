class AddUserRefToRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes,:user_id
    add_reference :recipes, :user, null: false, foreign_key: true
  end
end
