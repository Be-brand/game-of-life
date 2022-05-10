require_relative './helper'

module GameOfLife
  class Size1x1Test < SquareGameOfLifeTest
    size 1

    test 'cell remains dead' do
      assert_equal [[ 0 ]], @game.board.raw
      assert_equal @game.board.raw, @game.next.board.raw
    end

    test 'cell remains live' do
      enliven_cell!
      assert_equal [[ 1 ]], @game.board.raw
      assert_equal @game.board.raw, @game.next.board.raw
    end

    test 'cell can be killed' do
      enliven_cell!
      kill_cell!
      # TODO: board== works,
      assert_equal [[ 0 ]], @game.board.raw
    end

    protected
      def enliven_cell!
        super x: 1, y: 1
      end

      def kill_cell!
        super x: 1, y: 1
      end
  end
end
