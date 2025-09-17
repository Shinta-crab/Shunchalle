require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food = foods(:one)
  end

  test "should get index" do
    get foods_url
    assert_response :success
  end

  test "should get new" do
    get new_food_url
    assert_response :success
  end

  test "should create food" do
    assert_difference("Food.count") do
      post foods_url, params: { food: { category_id: @food.category_id, end_week: @food.end_week, food_name: @food.food_name, image: @food.image, is_rare: @food.is_rare, most_product_week: @food.most_product_week, recommend_week: @food.recommend_week, start_week: @food.start_week } }
    end

    assert_redirected_to food_url(Food.last)
  end

  test "should show food" do
    get food_url(@food)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_url(@food)
    assert_response :success
  end

  test "should update food" do
    patch food_url(@food), params: { food: { category_id: @food.category_id, end_week: @food.end_week, food_name: @food.food_name, image: @food.image, is_rare: @food.is_rare, most_product_week: @food.most_product_week, recommend_week: @food.recommend_week, start_week: @food.start_week } }
    assert_redirected_to food_url(@food)
  end

  test "should destroy food" do
    assert_difference("Food.count", -1) do
      delete food_url(@food)
    end

    assert_redirected_to foods_url
  end
end
