require 'test_helper'

class BusinessTest < ActiveSupport::TestCase

  def setup
    @owner = FactoryGirl.create(:owner)
    @business = @owner.businesses.create(FactoryGirl.attributes_for(:business))
  end

  test "creates with correct values" do
    assert_equal @business.name, "BookLa"
  end

  test "it should have a single owner" do
    assert_equal @business.owners.length, 1
  end

  test "it's owner should be test" do
    assert_equal @business.owners.first.email, "test@example.com"
  end  
end
