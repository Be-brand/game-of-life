require 'test_helper'
require 'game_of_life'

module GameOfLife
  class GameOfLifeTest < ActiveSupport::TestCase
    def setup
      @game = self.class.create_game
    end

    protected
      def self.create_game
        raise NoMethodError
      end

      def draw_board! &block
        BoardDrawer.new(@game).instance_eval &block
        advance!
      end

      # def enliven_cells! *coordinates
      #   coordinates.each { |c| enliven_cell! false, **c }
      #   advance!
      # end
      #
      # def enliven_cell! should_advance = true, **args
      #   @game.enliven_cell! **args
      #   advance! if should_advance
      # end
      #
      # def kill_cells! *coordinates
      #   coordinates.each { |c| kill_cell! false, **c }
      #   advance!
      # end
      #
      # def kill_cell! should_advance = true, **args
      #   @game.kill_cell! **args
      #   advance! if should_advance
      # end

      def advance!
        @game = @game.next
      end

      def assert_live x:, y:
        assert_equal 1, @game.board[y][x]
      end

      def assert_dead x:, y:
        assert_equal 0, @game.board[y][x]
      end

      def assert_board board
        assert_equal board, @game.board
      end

      def assert_next_board board
        assert_equal board, @game.next.board
      end

      def assert_remains_unchanged
        assert_equal @game.board, @game.next.board
      end
  end

  class SquareGameOfLifeTest < GameOfLifeTest
    protected
      def self.create_game
        Game.new height: @size, width: @size
      end

      def self.size size
        @size = size
      end
  end

  private
    class BoardDrawer
      def initialize game
        @game = game
      end

      def enliven! x:, y:
        @game.enliven_cell! x: x, y: y
      end

      def kill! x:, y:
        @game.kill_cell! x: x, y: y
      end
    end
end
