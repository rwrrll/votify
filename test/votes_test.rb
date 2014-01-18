require 'minitest/autorun'
require_relative File.join(%w{.. lib votes})

class VotesTest < Minitest::Unit::TestCase
  def setup
    @votes = Votes.new
  end

  def test_initial_state
    assert_equal [], @votes.votes
  end

  def test_count
    assert_equal 0, @votes.count

    @votes.cast('nathan')
    assert_equal 1, @votes.count
  end

  def test_none
    assert @votes.none?

    @votes.cast('nathan')
    refute @votes.none?
  end

  def test_reset
    @votes.cast('nathan')
    @votes.reset
    assert_equal [], @votes.votes
  end

  def test_voter_uniqueness
    @votes.cast('nathan')
    @votes.cast('nathan')
    assert_equal ['nathan'], @votes.votes
  end
end
