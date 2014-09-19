require "../src/JavaTestFinder"
require "test/unit"

class TestJavaTestFinder < Test::Unit::TestCase

  def setup
  	@testFinder = JavaTestFinder.new
  end

  def test_no_test
  	result = @testFinder.find_tests("../testData/NoTest.java.json")

  	assertResult(result, 0, 0)
  end

  def test_simple_test
  	result = @testFinder.find_tests("../testData/SimpleTest.java.json")

  	assertResult(result, 1, 1)
  end

  def test_multiple_tests_multiple_asserts
  	result = @testFinder.find_tests("../testData/MultipleAsserts.java.json")

  	assertResult(result, 2, 3)
  end

  def assertResult(result, expectedTests, expectedAssertions)
  	assert_equal(expectedTests, result["tests"])
  	assert_equal(expectedAssertions, result["asserts"])
  end
end
