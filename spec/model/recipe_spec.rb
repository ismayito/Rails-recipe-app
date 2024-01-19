require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) do
    User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password')
  end

  let(:recipe) do
    user.save!
    Recipe.create(user_id: user.id, name: 'soda dish', preparation_time: '3', cooking_time: '4',
                  description: 'it is best', public: true)
  end

  describe '#total_quantity' do
    it 'calculates the total quantity' do
      food1 = Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2, user_id: user.id)
      food2 = Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 3, user_id: user.id)
      RecipeFood.create(recipe_id: recipe.id, food_id: food1.id, quantity: 2)
      RecipeFood.create(recipe_id: recipe.id, food_id: food2.id, quantity: 3)

      expect(recipe.total_quantity).to eq(5)
    end
  end

  describe '#total_price' do
    it 'calculates the total price' do
      food1 = Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2, user_id: user.id)
      food2 = Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 3, user_id: user.id)
      RecipeFood.create(recipe_id: recipe.id, food_id: food1.id, quantity: 2)
      RecipeFood.create(recipe_id: recipe.id, food_id: food2.id, quantity: 3)

      # Reload the recipe object to get the updated associations
      recipe.save
      expect(recipe.total_price).to eq(2)
    end
  end
end
