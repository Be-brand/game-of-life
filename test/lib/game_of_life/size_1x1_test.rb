require_relative './helper'

module GameOfLife
  class Size1x1Test < SquareGameOfLifeTest
    size 1

    test 'cell remains dead' do
      assert_board [[ 0 ]]
      assert_remains_unchanged
    end

    test 'live cell dies' do
      draw_board! do
        enliven! x: 0, y: 0
      end
      assert_board [[ 1 ]]
      assert_next_board [[ 0 ]]
    end

    protected
      def enliven_cell!
        super x: 0, y: 0
      end

      def kill_cell!
        super x: 0, y: 0
      end
  end
end
