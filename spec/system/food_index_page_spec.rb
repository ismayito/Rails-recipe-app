# spec/system/recipes_index_page_spec.rb

require 'rails_helper'

RSpec.describe 'Recipes index page', type: :system do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }

  before do
    # Assuming you have a login mechanism, log in the user here
    # You may use devise helpers or implement your own login mechanism
    # Example: visit new_user_session_path, fill in credentials, click_button 'Log in'

    # Create some recipes for the user
    @recipes = [
      Recipe.create(description: 'Recipe 1 Description', user: user),
      Recipe.create(description: 'Recipe 2 Description', user: user)
      # Add more recipes as needed
    ]
  end

  it 'displays the recipes with remove buttons' do
    visit recipes_path

    @recipes.each_with_index do |recipe, index|
      expect(page).to have_content("Recipe #{index + 1}")
      expect(page).to have_content(recipe.description)

      # Ensure the remove button is present
      within('.recipe-container', text: recipe.description) do
        expect(page).to have_button('Remove')
      end
    end
  end
end
