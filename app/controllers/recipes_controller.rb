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

     # Debugging statements
    #  logger.debug "Recipe ID: #{@recipe.id}"
    #  logger.debug "Recipe Foods Count: #{@recipe_foods.count}"
    #  @recipe_foods.each do |recipe_food|
    #    logger.debug "Food Name: #{recipe_food.food.name}, Quantity: #{recipe_food.food.quantity}, Price: #{recipe_food.food.price}"
    #  end
  end
  
  #Action for public recipes
  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def general_shopping_list
    # Retrieve the current first user
    @user = User.first

    # Find all recipes of the logged-in user
    @user_recipes = @user.recipes.includes(recipe_foods: :food)

    # Retrieve the general food list of the user
    @general_food_list = @user.foods

    # Calculate the missing food items
    @missing_food_items = @general_food_list - @user_recipes.flat_map { |recipe| recipe.foods }

    # Calculate total quantity and total price of missing food items
    @total_quantity = @missing_food_items.sum(&:quantity)
    @total_price = @missing_food_items.sum(&:price)

  end
  
  

  def create; end
end
