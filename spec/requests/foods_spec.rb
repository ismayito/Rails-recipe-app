# spec/requests/foods_spec.rb

require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let(:user) do
    User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password')
  end

  let(:food) do
    Food.create(name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2, user_id: user.id)
  end

  before do
    sign_in user
  end

  describe 'GET /foods' do
    it 'returns http success' do
      get foods_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get foods_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /foods/new' do
    it 'returns http success' do
      get new_food_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /foods/:id' do
    it 'destroys the requested food' do
      food # Ensure the food exists
      expect do
        delete food_path(food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods list' do
      delete food_path(food)
      expect(response).to redirect_to(foods_path)
    end
  end
end
