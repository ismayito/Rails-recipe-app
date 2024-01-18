class FoodsController < ApplicationController
  # index action for fetching all the food items
  def index
    @foods = Food.all
  end

  # destroy action for deleting a single food item  def destroy
  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food Item successfully deleted.'
    redirect_to foods_path
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = User.first
    if @food.save
      flash[:success] = 'Food added successfully'
      redirect_to foods_path
    else
      puts "Errors: #{@food.errors.full_messages}" # Add this line for debugging
      flash.now[:error] = 'Food  not saved, check your Entries'
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
