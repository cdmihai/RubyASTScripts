require "../src/JavaTestFinder"
require "test/unit"

class TestJavaTestFinder < Test::Unit::TestCase

  def setup
  	@testFinder = JavaTestFinder.new
  end

  def test_no_test
  	assert_equal(0, @testFinder.find_tests("../testData/NoTest.java.json"))
  end

  def test_simple_test
  	assert_equal(1, @testFinder.find_tests("../testData/SimpleTest.java.json"))
  end

end
