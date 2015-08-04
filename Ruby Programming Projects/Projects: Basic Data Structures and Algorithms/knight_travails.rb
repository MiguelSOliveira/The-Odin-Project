class Board
  def initialize(height, width)
    @@height = height
    @@width  = width
    @board  = []
  end

  def create_board
    0.upto(@@height) do |height_index|
      0.upto(@@width) do |width_index|
        @board.push([height_index, width_index])
      end
    end
  end
end

class Knight < Board
  def initialize(position)
    @position_x = position[0]
    @position_y = position[1]
    @moves = [[2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2], [1,2]]
    @moves_available = Hash.new
  end

  def find_moves(target)
    queue = [[@position_x, @position_y]]
    visited_nodes = []
    while not queue.empty?
      temp_position = queue.shift
      @moves.each do |move|
        temp_pos_x = temp_position[0] + move[0]
        temp_pos_y = temp_position[1] + move[1]
        next if visited_nodes.include?([temp_pos_x, temp_pos_y]) or not temp_pos_x.between?(0, @@width) or not temp_pos_y.between?(0, @@height)
        visited_nodes << temp_position
        @moves_available[temp_position] = [] if not @moves_available[temp_position]
        @moves_available[temp_position] << [temp_pos_x, temp_pos_y]
        return @moves_available if [temp_pos_x, temp_pos_y] == target
        queue << [temp_pos_x, temp_pos_y]
      end
    end
  end
end


target = [4,3]
starting_point = [3,3]
board = Board.new(5,5)
board.create_board
knight = Knight.new(starting_point)
moves = knight.find_moves(target)

x = target
answer = [target]
while x != starting_point
  moves.each do |key, value|
    if value.include?(x)
      x = key
      answer.insert(0, x)
    end
  end
end
p answer
