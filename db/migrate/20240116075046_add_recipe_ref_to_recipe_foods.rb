class AddRecipeRefToRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipe_foods,:recipe_id
    add_reference :recipe_foods, :recipe, null: false, foreign_key: true
  end
end
