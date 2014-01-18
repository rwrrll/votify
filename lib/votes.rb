class Votes
  attr_accessor :votes

  def initialize
    reset
  end

  def cast(voter)
    @votes << voter unless @votes.include? voter
  end

  def count
    @votes.count
  end

  def none?
    count == 0
  end

  def reset
    @votes = []
  end
end
