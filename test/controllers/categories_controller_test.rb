require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.new(name: "sports")
    #Simulates and user to that is admin to test the priviledges
    @user = User.create(username: "John", email:"john@example.com", password:"password", admin: true)
  end

  test "Should get categories Index" do
    get categories_path
    assert_response :success
  end

  test "Should get new" do
    sign_in_user(@user, "password")
    get new_category_path
    assert_response :success
  end

  test "Should get show" do
    @category.save
    get category_path(@category)
    assert_response :success
  end

  test "Should redirect create when admin not logged in" do
    # Asserts that the numeric result of evaluating an 
    # expression (in this case is the Category.count)  
    # is not changed before and after invoking the passed in block
    # (in this case the block goes to categories path with the ).
    assert_no_difference "Category.count" do
      post categories_path, params:{category:{name: "sdafdsfsad"}}
    end
    assert_redirected_to categories_path
  end
end