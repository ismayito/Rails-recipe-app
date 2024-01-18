class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :delete, Recipe do |recipe|
      recipe.user == user
    end

    can :create, Food do |food|
      food.user == user
    end
  end
end
