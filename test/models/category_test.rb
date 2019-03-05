require 'test_helper'

class CategoryClass < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
  end

  test "Category should be valid" do

    assert @category.valid?
    
  end

  test "Name Should be present" do
    # After declaring empty @category.name an empty string (which is what we dont want because
    # we don't want an emppty string), and since this is a test we can initiate 
    # the name to be empty
    @category.name = " "

    # But we dont want this to be true so we use assert_not to the validity of category if @category.name
    # is empty. In other words after 
    # and empty string in the table value we want this to be false we want @category.name = " "
    # to be false but (before validations), this is allowed so it returen true 
    # that is why in the result test says Expected true to be nil or false, it was 
    # expected to be false 
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "test name should not be so long" do
    @category.name = "a" * 26 
    assert_not @category.valid?

  end

  test "test name should not be so short" do
    @category.name = "a" * 2 
    assert_not @category.valid?
  end

end