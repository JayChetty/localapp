require 'test_helper'

class BusinessTest < ActiveSupport::TestCase

  def setup
    @owner = FactoryGirl.create(:owner)
    @business = @owner.businesses.create(FactoryGirl.attributes_for(:business))
  end

  test "creates with correct values" do
    assert_equal "BookLa", @business.name
  end

  test "it should have a single owner" do
    assert_equal 1, @business.owners.length 
  end

  test "it's owner should be test" do
    assert_equal "test@example.com", @business.owners.first.email 
  end

  test "it should be verified by default" do
    assert_equal true, @business.verified 
  end  
end
