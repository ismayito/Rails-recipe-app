class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      flash[:success] = 'Recipe created successfully'
      redirect_to recipes_path
    else
      puts "Errors: #{@recipe.errors.full_messages}" # Add this line for debugging
      flash.now[:error] = 'Recipe not created, check your Entries'
      render :new
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    respond_to do |format|
      format.html { redirect_back(fallback_location: recipe_path(@recipe)) }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.public?
      authorize! :delete, @recipe
      @recipe.destroy
      flash[:notice] = 'Public recipe Item successfully deleted.'
      redirect_to public_recipes_path
    else
      @recipe.destroy
      flash[:notice] = 'Recipe Item successfully deleted.'
      redirect_to recipes_path
    end
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
