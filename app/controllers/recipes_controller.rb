class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe Item successfully deleted.'
    redirect_to recipes_path
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  # Action for public recipes
  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def general_shopping_list
    # Retrieve the current first user
    @user = current_user

    # Find all recipes of the logged-in user
    @user_recipes = @user.recipes.includes(recipe_foods: :food)

    # Retrieve the general food list of the user
    @general_food_list = @user.foods

    # Calculate the missing food items
    @missing_food_items = @general_food_list - @user_recipes.flat_map(&:foods)

    # Calculate total quantity and total price of missing food items
    @total_quantity = @missing_food_items.sum(&:quantity)
    @total_price = @missing_food_items.sum(&:price)
  end

  def create; end
end
