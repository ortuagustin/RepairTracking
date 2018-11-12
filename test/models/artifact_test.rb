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
end
