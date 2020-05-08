require 'minitest/autorun'
require 'minitest/pride'
require './solution'

class ProfitFinderTest < Minitest::Test
    def test_it_works
        profit_finder = ProfitFinder.new
        assert_equal 7, profit_finder.max_profit([7,1,5,3,6,4])
        assert_equal 4, profit_finder.max_profit([1,2,3,4,5])
        assert_equal 0, profit_finder.max_profit([7,6,4,3,1])
    end
end