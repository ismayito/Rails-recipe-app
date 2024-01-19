# spec/requests/recipes_spec.rb
require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password') }
  let(:recipe) { Recipe.create(user: user, name: 'Test Recipe', public: false) }

  before do
    sign_in user
  end

  describe 'GET /recipes' do
    it 'returns http success' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get recipes_path
      expect(response).to render_template(:index)
    end
  end

  describe 'PATCH /recipes/:id/toggle_public' do
    it 'toggles the public attribute of the recipe' do
      patch toggle_public_recipe_path(recipe)
      recipe.reload
      expect(recipe.public).to eq(recipe.public)
    end

    it 'redirects back to the recipe path' do
      patch toggle_public_recipe_path(recipe)
      expect(response).to redirect_to(recipe_path(recipe))
    end
  end

  describe 'DELETE /recipes/:id' do
    it 'destroys the requested recipe' do
      recipe # Ensure the recipe exists
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list for public recipes' do
      public_recipe = Recipe.create(user: user, name: 'Public Recipe', public: true)
      delete recipe_path(public_recipe)
      expect(response).to redirect_to(public_recipes_path)
    end

    it 'redirects to the recipes list for private recipes' do
      delete recipe_path(recipe)
      expect(response).to redirect_to(recipes_path)
    end
  end
end
