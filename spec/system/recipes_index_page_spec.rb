# spec/system/food_index_spec.rb

require 'rails_helper'

RSpec.describe 'recipe index page', type: :system do
  let(:user) { User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password') }

  let!(:foods) do
    Food.create(
      [
        { name: 'rice', measurement_unit: 'kilograms', price: 1, quantity: 2, user_id: user.id },
        { name: 'posho', measurement_unit: 'kilograms', price: 1, quantity: 2, user_id: user.id }
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

  it 'should show all food information' do
    visit foods_path
  end
end
