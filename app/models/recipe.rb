class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods,dependent: :destroy
  has_many :foods, through: :recipe_foods  # Add this line to establish the association with foods

  def total_quantity
    recipe_foods.joins(:food).sum(:quantity)
  end

  def total_price
    recipe_foods.joins(:food).sum(:price)
  end
end
