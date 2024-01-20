class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      flash[:success] = ' Ingredient created!'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      puts "Errors: #{@recipe_food.errors.full_messages}" # Add this line for debugging
      flash[:error] = 'Ingredient Not added, try again later'
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Food item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    # authorize! :destroy, @recipe_food
    @recipe_food.destroy!

    respond_to do |format|
      format.html { redirect_to recipe_url, notice: 'Ingredient removed successfully.' }
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity, :price)
  end
end
