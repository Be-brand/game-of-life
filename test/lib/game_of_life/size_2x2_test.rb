require_relative './helper'

module GameOfLife
  class Size2x2Test < SquareGameOfLifeTest
    size 2

    test 'dead square stays dead' do
      assert_board [[0, 0], [0, 0]]
      assert_remains_unchanged
    end

    test 'live square stays live' do
      draw_board! do
        enliven! x: 0, y: 0
        enliven! x: 1, y: 0
        enliven! x: 0, y: 1
        enliven! x: 1, y: 1
      end
      assert_remains_unchanged
    end

    test 'three cells populate corner' do
      draw_board! do
        enliven! x: 0, y: 0
        enliven! x: 1, y: 0
        enliven! x: 0, y: 1
      end
      assert_next_board [[1, 1], [1, 1]]
    end

    test 'live corner cell dies by underpopulation' do
      draw_board! do
        enliven! x: 0, y: 0
      end
      assert_board [[1, 0], [0, 0]]
      assert_next_board [[0, 0], [0, 0]]
    end
  end
end
