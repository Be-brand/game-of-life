require_relative './helper'

module GameOfLife
  class Size3x3Test < SquareGameOfLifeTest
    size 3

    test 'cell with 4 neighbors dies of overpopulation' do
      draw_board! do
        enliven! x: 0, y: 0
        enliven! x: 1, y: 0
        enliven! x: 2, y: 0
        enliven! x: 0, y: 1
        enliven! x: 1, y: 1
      end
      advance!
      assert_dead x: 1, y: 0
    end
  end
end
