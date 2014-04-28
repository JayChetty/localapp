require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  def setup
    @owner = FactoryGirl.create(:owner)
  end

  test "creates with correct values" do
    assert_equal @owner.email, "test@example.com"
    assert_equal @owner.password, "asdfasdf"
  end

end
