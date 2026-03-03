require "test_helper"

class SkillTest < ActiveSupport::TestCase
  setup do
    @skill = skills(:rails_skill)
  end

  # Validations
  test "valid skill" do
    assert @skill.valid?
  end

  test "requires name" do
    @skill.name = nil
    assert_not @skill.valid?
    assert_includes @skill.errors[:name], "can't be blank"
  end

  # Scopes
  test "featured scope returns only featured skills" do
    featured = Skill.featured
    assert_includes featured, skills(:rails_skill)
    assert_includes featured, skills(:react_skill)
  end

  test "ordered scope orders by position" do
    ordered = Skill.ordered
    assert_equal skills(:rails_skill), ordered.first
  end

  # Defaults
  test "proficiency defaults to 80" do
    skill = Skill.new(name: "Test Skill")
    assert_equal 80, skill.proficiency
  end
end
