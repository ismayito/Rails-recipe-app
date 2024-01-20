# spec/system/recipe_show_spec.rb

require 'rails_helper'

RSpec.describe 'recipe show page', type: :system do
  let(:user) { User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password') }

  let!(:recipe) do
    Recipe.create(
      name: 'Recipe 2',
      preparation_time: Time.now,
      cooking_time: Time.now,
      public: false,
      user_id: user.id
    )
  end

  let!(:recipe_foods) do
    RecipeFood.create(
      [
        { recipe_id: recipe.id,
          food_id: Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2,
                               user_id: user.id).id },
        { recipe_id: recipe.id,
          food_id: Food.create(name: 'posho', measurement_unit: 'kilograms', price: 1, quantity: 2,
                               user_id: user.id).id }
      ]
    )
  end

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_current_path(root_path, wait: 5)
  end

  it 'displays recipe details and food information' do
    visit recipe_path(recipe)

    expect(page).to have_css('.title', text: 'Recipe 2')
    expect(page).to have_content(recipe.preparation_time.strftime('%H:%M'))
    expect(page).to have_content(recipe.cooking_time.strftime('%H:%M'))
    expect(page).to have_button('Generate shopping list')

    # Assuming you have logic to toggle public state
    expect(page).to have_css('.public-title', text: 'Public')
    expect(page).to have_css('.icon-button')

    recipe_foods.each do |recipe_food|
      expect(page).to have_content(recipe_food.food.name) if recipe_food.food
      expect(page).to have_content(recipe_food.food.quantity) if recipe_food.food
      expect(page).to have_content(recipe_food.food.price) if recipe_food.food
      expect(page).to have_button('Modify')
      expect(page).to have_button('Remove')
    end
  end
end
