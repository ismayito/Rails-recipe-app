# spec/system/shopping_list_spec.rb

require 'rails_helper'

RSpec.describe 'Shopping List page', type: :system do
  let(:user) { User.create(name: 'Mayito', email: 'mayito@gmail.com', password: 'password') }

  let!(:missing_food_items) do
    [
      Food.create(name: 'Rice', quantity: 2, price: 1, user_id: user.id),
      Food.create(name: 'Posho', quantity: 3, price: 2, user_id: user.id)
      # Add more missing food items as needed for your test case
    ]
  end

  before do
    # Log in the user or perform any necessary setup
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_current_path(root_path, wait: 5)
  end

  it 'displays shopping list details' do
    visit general_shopping_list_path

    expect(page).to have_css('.shopping-title', text: 'Shopping list')

    # Assuming you have logic to calculate missing_food_items and total_price
    expect(page).to have_content("Amount of food Items to buy: #{missing_food_items.size}")

    missing_food_items.each do |food|
      expect(page).to have_content(food.name)
      expect(page).to have_content(food.quantity)
      expect(page).to have_content("$#{food.price}")
    end
  end
end
