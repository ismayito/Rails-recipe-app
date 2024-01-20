# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Assuming you have User, Food, Recipe, and RecipeFood models defined

# Create a user
user = User.create(name: "John Doe")

# Create foods associated with the user
food1 = user.foods.create(name: "Apple", measurement_unit:"kilograms", quantity: 5, price: 1.5)
food2 = user.foods.create(name: "Chicken", measurement_unit:"kilograms", quantity: 2, price: 8.0)

# Create a recipe associated with the user
recipe = user.recipes.create(
  name: "Fruit Salad",
  preparation_time: Time.zone.parse("03:00"),
  cooking_time: Time.zone.parse("01:00"),
  description: "A delicious fruit salad."
)

# Create RecipeFood records associating foods with the recipe
RecipeFood.create(recipe: recipe, food: food1)
RecipeFood.create(recipe: recipe, food: food2)

# Insert a user
user = User.create(name: "John Doe")

# Insert some foods
food1 = Food.create(name: "Meat", measurement_unit: "grams", price: 12, quantity: 3, user_id: user.id)
food2 = Food.create(name: "Potatoes", measurement_unit: "pieces", price: 5, quantity: 10, user_id: user.id)

# Insert a recipe
recipe = Recipe.create(name: "Grilled Meat and Potatoes", preparation_time: "01:30:00", cooking_time: "00:45:00", description: "Delicious grilled meat and potatoes", public: true, user_id: user.id)

# Associate foods with the recipe
RecipeFood.create(recipe_id: recipe.id, food_id: food1.id)
RecipeFood.create(recipe_id: recipe.id, food_id: food2.id)

# Create a User
user = User.create(name: "John Doe")

# Create a Recipe with associated RecipeFood and Food records
recipe = Recipe.create(
  name: "Grilled Meat and Potatoes",
  preparation_time: "01:30:00",
  cooking_time: "00:45:00",
  description: "Delicious grilled meat and potatoes",
  public: true,
  user: user
)

# Create a Food record with public set to true
food = Food.create(
  name: "Meat",
  measurement_unit: "calories",
  price: 12,
  quantity: 3,
  user: user
)

# Create a RecipeFood record associating the Recipe and Food
recipe_food = RecipeFood.create(
  recipe: recipe,
  food: food,
  quantity: 2  # Set a non-nil value for quantity
)

