require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
  end

  test "should show category listing" do
    # Get the category index path which can be found in the rake routes categories#indec
    get categories_path
    # asserts that there is a link that will take you to categories/index
    assert "categories/index"
    # After listing all the categories the link asserts that the link will take them to the correspondent pages
    # with their link path and the i Dont know what text has to do 
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end