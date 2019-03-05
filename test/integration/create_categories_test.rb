require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    #Simulates and user to that is admin to test the priviledges
    @user = User.create(username: "John", email:"john@example.com", password:"password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_user(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params:{category: {name: "football"}}
      follow_redirect!
    end
  assert_template 'categories/index'
  assert_match "football", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_user(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params:{category: {name: " "}}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 
end