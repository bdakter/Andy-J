# tic_tac_toe.rb
# Walk-through program

# Game Description
# Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a
# turn and marks a square on the board. First player to reach 3 squares in a
# row, including diagonals, wins. If all 9 squares are marked and no player
# has 3 squares in a row, then teh game is a tie.

# Outline Sequence of Gameplay
# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2.
# 8. Play again?
# 9. If yes, go to #1
# 10. Good bye!
require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
FIRST_MOVE = 'choose' # select "player", "computer", or "choose"

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimiter=', ', conjuction='or')
  # joined_arr = []
  # arr.each do |num|
  #   joined_arr << num
  # end
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(' or ')
  else
    # This will mutate arr but in this program the arr will always be calculated
    # again before being passed into this method
    arr[-1] = "#{conjuction} #{arr[-1]}"
    arr.join(delimiter)
  end
end
# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def is_5_available?(brd)
  empty_squares(brd).include?(5)
end

def find_at_risk_square(brd, marker)
  at_risk_lines = WINNING_LINES.select do |line|
    brd.values_at(*line).count(marker) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
  end

  at_risk_squares = empty_squares(brd).select { |square| at_risk_lines.flatten.include?(square) }

  at_risk_squares.sample
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ', ', 'or')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER # player is the X
end

def computer_places_piece!(brd)
  square = if find_at_risk_square(brd, COMPUTER_MARKER)
             find_at_risk_square(brd, COMPUTER_MARKER)
           elsif find_at_risk_square(brd, PLAYER_MARKER)
             find_at_risk_square(brd, PLAYER_MARKER)
           elsif is_5_available?(brd)
             5
           else
             empty_squares(brd).sample
           end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def increment_win_count(brd, win_hsh)
  win_hsh[detect_winner(brd)] += 1
end

def display_scores(scores_hsh)
  scores_hsh.map { |k, v| "#{k}: #{v.to_s}"}.join(' | ')
end

def place_piece!(player, brd, wins_arr)
  case player
  when 'player'
    display_board(brd)
    prompt "The score is --> #{display_scores(wins_arr)}"
    player_places_piece!(brd)
  when 'computer' then computer_places_piece!(brd)
  when 'choose' then prompt_play_order
  end
end

def play_first(first_player)
  case first_player
  when 'player'
    ['player', 'computer']
  when 'computer'
    ['computer', 'player']
  when 'choose'
    loop do
      prompt "Who goes first? Choose '(P)layer' or '(C)omputer':"
      choice = gets.chomp
      case choice.downcase[0]
      when 'p'
        break ['player', 'computer']
      when 'c'
        break ['computer', 'player']
      else
        prompt "That is not a valid choice."
      end
    end
  end
end



prompt "Welcome to Tic Tac Toe!"
loop do # play again loop
  player1, player2 = play_first(FIRST_MOVE)
  prompt "First to win 5 games wins the match."
  wins_count = {'Player' => 0, 'Computer' => 0}
  game_count = 1
  loop do # match loop
    board = initialize_board

    loop do # game loop
      place_piece!(player1, board, wins_count)
      break if someone_won?(board) || board_full?(board)

      place_piece!(player2, board, wins_count)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      increment_win_count(board, wins_count)
      prompt "#{detect_winner(board)} won the game!"
    else
      prompt "It's a tie!"
    end

    game_count += 1
    break if wins_count.values.include?(5)
    prompt "Ready to play game \##{game_count}? Press ENTER to continue..."
    gets
  end

  prompt "#{wins_count.key(5)} won the match!"

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
