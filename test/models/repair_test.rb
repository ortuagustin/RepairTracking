require 'test_helper'

class RepairTest < ActiveSupport::TestCase
  setup do
    @agus = customers(:agus)
    @heladera = artifacts(:heladera)
  end

  test "it should add the estimated days to the created_at date to calculate the estimated_ date " do
    repair = Repair.create(customer: @agus, artifact: @heladera, estimated_days: 5)
    expected = 5.days.since
    assert_equal expected.to_i, repair.estimated_date.to_i
  end

  test "it returns its creation date as last_revision_date when no revisions attached" do
    repair = Repair.create(customer: @agus, artifact: @heladera, estimated_days: 5)
    expected = repair.created_at

    assert_equal expected.to_i, repair.last_revision_date.to_i
  end

  test "it returns the last_revision_date when one revision attached" do
    repair = Repair.create(customer: @agus, artifact: @heladera, estimated_days: 5)
    revision = Revision.create(repair: repair, notes: 'bla')
    repair.revisions << revision
    expected = revision.created_at

    assert_equal expected.to_i, repair.last_revision_date.to_i
  end

  test "it returns the last_revision_date when many revisions attached" do
    repair = Repair.create(customer: @agus, artifact: @heladera, estimated_days: 5)
    repair.revisions << Revision.create(repair: repair, notes: 'first')
    repair.revisions << Revision.create(repair: repair, notes: 'second')

    last_revision = Revision.create(repair: repair, notes: 'last')
    last_revision.created_at = 5.days.since
    last_revision.save!
    repair.revisions << last_revision
    expected = last_revision.created_at

    assert_equal expected.to_i, repair.last_revision_date.to_i
  end

  test "should accept repair with valid attributes" do
    repair = Repair.new(customer: @agus, artifact: @heladera, estimated_days: 5)
    assert repair.valid?
  end

  test "should generate repair code when saved" do
    repair = Repair.create(customer: @agus, artifact: @heladera, estimated_days: 5)
    assert_equal "ASO#{repair.id}", repair.code
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
