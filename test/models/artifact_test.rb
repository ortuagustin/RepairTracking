require 'test_helper'

class ArtifactTest < ActiveSupport::TestCase
  test "should accept artifact with valid attributes" do
    artifact = Artifact.new(name: 'televisor', model: 'qw1234')
    assert artifact.valid?
  end

  test "should not accept artifact without a name" do
    artifact = Artifact.new(name: nil, model: 'qw1234')
    assert artifact.invalid?
  end

  test "should not accept artifact with a blank or empty name" do
    artifact = Artifact.new(name: '', model: 'qw1234')
    assert artifact.invalid?
  end

  test "should not accept artifact without a model" do
    artifact = Artifact.new(name: 'televisor', model: nil)
    assert artifact.invalid?
  end

  test "should not accept artifact with a blank or empty model" do
    artifact = Artifact.new(name: 'televisor', model: '')
    assert artifact.invalid?
  end

  test "should not accept artifact with duplicate model" do
    artifact = Artifact.new(name: 'televisor', model: 'qw1234')
    duplicated_artifact = Artifact.new(name: 'heladera', model: 'qw1234')
    assert artifact.valid?
    artifact.save!
    assert duplicated_artifact.invalid?
  end

  test "deleting an artifact should delete associated repairs" do
    agus = customers(:agus)
    heladera = artifacts(:heladera)

    Repair.create!(customer: agus, artifact: heladera, estimated_days: 5)
    Repair.create!(customer: agus, artifact: heladera, estimated_days: 5)
    assert_equal 2, Repair.count

    heladera.destroy
    assert_equal 0, Repair.count
  end
end
