require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  setup do
    @agus = customers(:agus)
  end

  test "it returns its initials" do
    assert 'ASO', @agus.initials
  end

  test "should accept customer with valid attributes" do
    assert @agus.valid?
  end

  test "should not accept customer without a name" do
    @agus.name = nil
    assert @agus.invalid?
  end

  test "should not accept customer with a blank name" do
    @agus.name = ''
    assert @agus.invalid?
  end

  test "should not accept customer without a surname" do
    @agus.surname = nil
    assert @agus.invalid?
  end

  test "should not accept customer with a blank surname" do
    @agus.surname = ''
    assert @agus.invalid?
  end

  test "should not accept customer without a email" do
    @agus.email = nil
    assert @agus.invalid?
  end

  test "should not accept customer with a blank email" do
    @agus.email = ''
    assert @agus.invalid?
  end

  test "should not accept customer without a phone" do
    @agus.phone = nil
    assert @agus.invalid?
  end

  test "should not accept customer with a blank phone" do
    @agus.phone = ''
    assert @agus.invalid?
  end

  test "deleting a customer should delete associated repairs" do
    agus = customers(:agus)

    Repair.create!(customer: agus, artifact: Artifact.first, estimated_days: 5)
    Repair.create!(customer: agus, artifact: Artifact.second, estimated_days: 5)
    assert_equal 2, Repair.count

    agus.destroy
    assert_equal 0, Repair.count
  end
end
