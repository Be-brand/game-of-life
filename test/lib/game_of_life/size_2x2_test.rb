require_relative './helper'

module GameOfLife
  class Size2x2Test < SquareGameOfLifeTest
    size 2

    test 'dead square stays dead' do
      assert_equal [[ 0, 0 ], [ 0, 0 ]], @game.board.raw
      assert_equal @game.board.raw, @game.next.board.raw
    end
  end
end
