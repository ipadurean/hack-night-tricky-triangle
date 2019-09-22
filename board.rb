
require 'pry'
class Board

  BOARD_SIZE = 5
  PEG_MARKER = '•'
  HOLE_MARKER = 'o'

  def initialize
    @board = move(*user_input)
  end

  def user_input
    puts "Please enter move"
    gets.chomp.split("").map {|el| el.to_i}
   
  end

  def create_initial_board
    number_of_spaces = find_number_of_spaces
    positions = all_positions(number_of_spaces)
    divide_board(positions)
  end

  def find_number_of_spaces
    (BOARD_SIZE * BOARD_SIZE) - BOARD_SIZE
  end

  def all_positions(number_of_spaces)
    positions = Array.new(number_of_spaces, PEG_MARKER)
    positions[0] = HOLE_MARKER
    positions
    
  end

  def divide_board(positions)
   
    board = []
    positions.each_with_index do |_a, i|
      board.push(positions.shift(i + 1))
    end
    board
  end

  def print_board
    
    column_num = 1
    puts "               #{column_num}"
    @board.each_with_index do |row, index|
      column_num += 1
      print "#{map_row_to_alphabet(index)}#{row_front_padding(index)}"
      print_board_row(row)
      print_column_number(column_num)
    end
   @board
  end

  def print_board_row(row)
    row.each do |space|
      print "#{space}   "
    end
  end

  def print_column_number(column_number)
     puts (column_number <= BOARD_SIZE ? "#{column_number}" : '')
  end

  def row_front_padding(row_number)
    '  ' * ((BOARD_SIZE + 1) - row_number)
  end

  def map_row_to_alphabet(row_number)
    alphabet = 'A'..'Z'
    rows = alphabet.to_a.first(BOARD_SIZE)
    rows[row_number]
  end

    def move(a1, a2, b1, b2)
      b = create_initial_board
      if (b[a1][a2] == PEG_MARKER) && (b[b1][b2] == HOLE_MARKER)
        b[a1][a2] =  HOLE_MARKER
        b[b1][b2] =  PEG_MARKER
          if (b1-a1) == 2 && (b2-a2) == 0
             b[a1 + 1][a2] = HOLE_MARKER
          elsif (b1-a1) == -2 && (b2-a2) == 0
             b[a1 - 1][a2] = HOLE_MARKER
          elsif (b1-a1) == 0 && (b2-a2) == 2
             b[a1][a2 + 1] = HOLE_MARKER
          elsif (b1-a1) == 0 && (b2-a2) == -2
            b[a1][a2 - 1] = HOLE_MARKER
          elsif (b1-a1) == -2 && (b2-a2) == -2
             b[a1 - 1][a2 - 1] = HOLE_MARKER
          elsif (b1-a1) == 2 && (b2-a2) == 2
            b[a1 + 1][a2 + 1] = HOLE_MARKER
          else
        puts "this is not a valid move"
          end
      else
        puts "this is not a valid move"
    end
  
     b
  end

end

board = Board.new
board.print_board
