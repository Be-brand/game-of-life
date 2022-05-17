module GameOfLife
  class Game
    attr_reader :board

    def initialize height: nil, width: nil, board: nil
      if board.nil?
        board = Board.new height: height,
                          width:  width
      end
      @height     = height
      @width      = width
      @board      = board.freeze
      @next_board = @board.clone
      @changes    = []
    end

    def next
      Game.new height: @height,
               width:  @width,
               board:  next_board
    end

    def enliven_cell! x:, y:
      change_cell! 1, x: x, y: y
    end

    def kill_cell! x:, y:
      change_cell! 0, x: x, y: y
    end

    protected
      def change_cell! state, x:, y:
        change_board! do |board|
          board[y][x] = state
        end
      end

      def change_board! &change
        @changes.push change
      end

      def next_board
        board = calculate_next_board @next_board
        @changes.each { |c| c.call board }
        @changes = []
        Board.new board, height: @height, width: @width
      end

      def calculate_next_board board
        board.map_cells do |value, x, y|
          neighbors = board.live_neighbors_of x: x, y: y
          next 0 if neighbors < 2
          next 1 if neighbors == 3
          next 0 if neighbors > 3
          value
        end
      end
  end

  private
    class Board < Array
      def initialize board = nil, height:, width:
        @height = height
        @width  = width
        board   = make_board if board.nil?
        super board
      end

      def map_cells &block
        each_with_index.map do |row, row_i|
          row.each_with_index.map do |cell, cell_i|
            block.call cell, cell_i, row_i
          end
        end
      end

      def live_neighbors_of x:, y:
        neighbors = neighbors_of x: x, y: y
        neighbors.select { |c| c == 1 }.length
      end

      def neighbors_of x:, y:
        points = (x - 1..x + 1).to_a.product (y - 1..y + 1).to_a
        points.filter! { |c| c != [x, y] }
        points.map do |x, y|
          self[y][x] if in_board? x: x, y: y
        end
      end

      private
        def make_board
          Array.new(@height).map do
            Array.new(@width).map do
              0
            end
          end
        end

        def in_board? x:, y:
          (0...@height) === y and (0...@width) === x
        end
    end
end
