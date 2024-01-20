class FoodsController < ApplicationController
  # require login before accesing the application
  before_action :authenticate_user!, only: [:index]
  before_action :require_login, only: [:index]

  # index action for fetching all the food items
  def index
    @foods = current_user.foods
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
    @food.user = current_user
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

  def require_login
    redirect_to foods_path unless user_signed_in?
  end
end
