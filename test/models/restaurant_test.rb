require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  test "validates presence of name" do 
    restaurant = Restaurant.new(name: ' ')
    refute restaurant.valid?
    assert_includes restaurant.errors.details[:name], error: :blank
  end 
end
