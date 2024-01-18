class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  scope :public_foods, -> { where(public: true) }

  def total_quantity
    recipe_foods.sum(:quantity)
  end

  def total_price
    recipe_foods.sum(:price)
  end
end
