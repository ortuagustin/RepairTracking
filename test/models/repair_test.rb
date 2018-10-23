require 'test_helper'

class RepairTest < ActiveSupport::TestCase
  setup do
    @agus = customers(:agus)
    @heladera = artifacts(:heladera)
  end

  test "should accept repair with valid attributes" do
    repair = Repair.new(customer: @agus, artifact: @heladera, estimated_days: 5)
    assert repair.valid?
  end

  test "should not accept repair without a customer" do
    repair = Repair.new(customer: nil, artifact: @heladera, estimated_days: 5)
    assert repair.invalid?
  end

  test "should not accept repair without an artifact" do
    repair = Repair.new(customer: @agus, artifact: nil, estimated_days: 5)
    assert repair.invalid?
  end

  test "should not accept repair without estimated days" do
    repair = Repair.new(customer: @agus, artifact: @heladera, estimated_days: nil)
    assert repair.invalid?
  end

  test "should not accept repair with blank estimated days" do
    repair = Repair.new(customer: @agus, artifact: @heladera, estimated_days: '')
    assert repair.invalid?
  end

  test "estimated days should be numeric" do
    repair = Repair.new(customer: @agus, artifact: @heladera, estimated_days: 'asd')
    assert repair.invalid?
  end
end
