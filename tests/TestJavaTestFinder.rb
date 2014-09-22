require "../src/JavaTestFinder"
require "test/unit"

class TestJavaTestFinder < Test::Unit::TestCase

  def setup
  	@testFinder = JavaTestFinder.new
  end

  def test_no_test
  	result = @testFinder.find_tests("../testData/NoTest.java.json")

  	assertResult(result, 0, 0, 0)
  end

  def test_simple_test
  	result = @testFinder.find_tests("../testData/SimpleTest.java.json")

  	assertResult(result, 1, 1, 1)
  end

  def test_multiple_tests_multiple_asserts
  	result = @testFinder.find_tests("../testData/MultipleAsserts.java.json")

  	assertResult(result, 2, 3, 3)
  end

  def test_indirect_asserts
  	result = @testFinder.find_tests("../testData/InteraMethodAsserts.java.json")

  	assertResult(result, 2, 2, 4)
  end

  def test_shared_indirect_asserts
  	result = @testFinder.find_tests("../testData/SharedInteraMethodAsserts.java.json")

  	assertResult(result, 3, 2, 4)
  end

  def assertResult(result, expected_tests, direct_asserts, all_asserts)
  	assert_equal(expected_tests, result["tests"])
  	assert_equal(direct_asserts, result["directAsserts"])
  	assert_equal(all_asserts, result["allAsserts"])
  end
end
