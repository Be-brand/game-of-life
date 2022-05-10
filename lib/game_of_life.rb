module GameOfLife
  class Game
    attr_reader :board

    def initialize height: nil, width: nil, board: nil
      if board.nil?
        raise 'invalid input' if [board, height, width].all? &:nil?
        board = Board.new height: height,
                          width:  width
      end
      @board      = board.freeze
      @next_board = @board.clone
    end

    def next
      Game.new board: @next_board
    end

    def enliven_cell! x:, y:
      change_cell! 1, x: x, y: y
    end

    def kill_cell! x:, y:
      change_cell! 0, x: x, y: y
    end

    protected
      def change_cell! state, x:, y:
        @next_board.raw[x - 1][y - 1] = state
      end
  end

  private
    class Board
      def initialize height:, width:
        @height = height
        @width  = width
        @board  = make_board
      end

      def raw
        @board
      end

      private
        def make_board
          Array.new(@height).map do
            Array.new(@width).map do
              0
            end
          end
        end
    end
end
