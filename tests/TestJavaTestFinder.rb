require "../src/JavaTestFinder"
require "test/unit"

class TestJavaTestFinder < Test::Unit::TestCase

  def test_sample
    assert_equal(3, JavaTestFinder.new.add(1,2))
  end

end
