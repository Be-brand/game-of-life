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

      def enliven_cell! **args
        @game.enliven_cell! **args
        advance!
      end

      def kill_cell! **args
        @game.kill_cell! **args
        advance!
      end

      def advance!
        @game = @game.next
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
end
