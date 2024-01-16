class AddFoodRefToRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipe_foods,:food_id
    add_reference :recipe_foods, :food, null: false, foreign_key: true
  end
end
