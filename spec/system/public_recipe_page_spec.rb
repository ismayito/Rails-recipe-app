# spec/system/public_recipe_page_spec.rb

require 'rails_helper'

RSpec.describe 'Public Recipes page', type: :system do
  let(:user) { User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password') }

  let!(:public_recipes) do
    [
      Recipe.create(name: 'Recipe 1', public: true, user_id: user.id),
      Recipe.create(name: 'Recipe 2', public: true, user_id: user.id)
    ]
  end

  let!(:recipe_foods) do
    RecipeFood.create(
      [
        { recipe_id: public_recipes[0].id,
          food_id: Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2,
                               user_id: user.id).id },
        { recipe_id: public_recipes[0].id,
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

  it 'displays public recipes with delete links and total information' do
    visit public_recipes_path

    public_recipes.each do |public_recipe|
      expect(page).to have_content(public_recipe.name)
      expect(page).to have_link('Delete', href: recipe_path(public_recipe))
      expect(page).to have_content("Total food Items: #{public_recipe.total_quantity}")
      expect(page).to have_content("Total price: $#{public_recipe.total_price}")
    end
  end
end
