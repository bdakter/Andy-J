require 'pry'

def prompt(msg)
  puts "=> #{msg}"
end

def join_or(array)
  case array.size
  when 1
    array.first
  when 2
    "#{array.first} or #{array.last}"
  else
    "#{array[0..-2].join(', ')} or #{array.last}"
  end
end

def clear_screen
  system('clear') || system('cls')
end

class Move
  VALUES = %w(rock paper scissors Spock lizard).freeze

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Rock < Move
  def >(other)
    [Scissors, Lizard].include?(other.class)
  end

  def <(other)
    [Spock, Paper].include?(other.class)
  end
end

class Paper < Move
  def >(other)
    [Rock, Spock].include?(other.class)
  end

  def <(other)
    [Scissors, Lizard].include?(other.class)
  end
end

class Scissors < Move
  def >(other)
    [Paper, Lizard].include?(other.class)
  end

  def <(other)
    [Rock, Spock].include?(other.class)
  end
end

class Spock < Move
  def >(other)
    [Rock, Scissors].include?(other.class)
  end

  def <(other)
    [Paper, Lizard].include?(other.class)
  end
end

class Lizard < Move
  def >(other)
    [Paper, Spock].include?(other.class)
  end

  def <(other)
    [Rock, Scissors].include?(other.class)
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end

  def make_choice(choice)
    { 'rock' => Rock,
      'paper' => Paper,
      'scissors' => Scissors,
      'Spock' => Spock,
      'lizard' => Lizard }[choice].new(choice)
  end

  def display_in_header
    name.center(12)
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      prompt "What's your name?"
      n = gets.chomp.strip
      break unless n.empty?
      prompt 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      prompt "Please choose #{join_or(Move::VALUES)}:"
      choice = gets.chomp
      break if valid_choices.keys.include? choice
      prompt 'sorry, invalid choice.'
    end
    choice = valid_choices[choice]
    self.move = make_choice(choice)
  end

  private

  def valid_choices
    { 'rock' => 'rock', 'r' => 'rock', 'R' => 'rock',
      'paper' => 'paper', 'p' => 'paper', 'P' => 'paper',
      'scissors' => 'scissors', 's' => 'scissors',
      'Spock' => 'Spock', 'S' => 'Spock',
      'lizard' => 'lizard', 'l' => 'lizard', 'L' => 'lizard' }
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = make_choice(Move::VALUES.sample)
  end
end

# Collaborator class for Player
class Score
  attr_reader :round
  attr_accessor :game

  def initialize
    @round = 0
    @game = 0
  end

  def reset
    @round = 0
  end

  def ==(other)
    @round == other
  end

  def +(other)
    @round += other
    self
  end

  def to_s
    @round.to_s
  end
end

# Most items displayed to screen
module Displayable
  def display_welcome_message
    prompt '------------------------------------------------'
    prompt 'Welcome to Rock, Paper, Scissors, Spock, Lizard!'
    prompt "First to #{self.class::MAX_SCORE} wins!"
    prompt '------------------------------------------------'
  end

  def display_goodbye_message
    prompt '------------------------------------------------------------------'
    prompt 'Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!'
    prompt '------------------------------------------------------------------'
  end

  def display_moves
    prompt "#{human.name} chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    human_move = human.move
    computer_move = computer.move
    if human_move > computer_move
      prompt "#{human.name} won the round!"
    elsif human_move < computer_move
      prompt "#{computer.name} won the round!"
    else
      prompt "It's a tie!"
    end
  end

  def format_history
    result = []
    @history[:human].size.times do |move_num|
      line = ''
      # binding.pry
      line << @history[:human][move_num].center(12) + '     '
      line << @history[:computer][move_num].center(12)
      line << @history[:game][move_num].center(4)
      line << @history[:round][move_num].center(10)
      result << line
    end
    result
  end

  def display_history
    prompt '-----------History----------Game---Round---'
    format_history.each { |line| prompt line }
    prompt '-------------------------------------------'
  end

  def display_game_winner
    winner = human.score == self.class::MAX_SCORE ? human : computer
    prompt "#{winner.name} won the game!"
  end

  def display_score
    human_score = human.score
    computer_score = computer.score
    spacing = ' ' * 16

    prompt '---------Round Score---------'
    prompt "#{human_score}#{spacing}#{computer_score}".center(29)
    prompt '---------Game Score----------'
    prompt "#{human_score.game}#{spacing}#{computer_score.game}".center(29)
    prompt ''
  end

  def display_header
    prompt human.display_in_header + '-----' + computer.display_in_header
  end

  def show_display
    clear_screen
    display_moves
    display_winner
    display_header
    display_score
    display_history
  end
end

# Game Orchestration Engine
class RPSGame
  include Displayable

  MAX_SCORE = 3

  attr_accessor :human, :computer

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @game = 1
    @round = 0
    @history = { human: [], computer: [], game: [], round: [] }
  end

  private

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def next_game
    human.score.reset
    computer.score.reset
    @game += 1
    @round = 0
  end

  def update_round
    @round += 1
  end

  def update_history
    @history[:human] << human.move.to_s
    @history[:computer] << computer.move.to_s
  end

  def update_game_round
    @history[:game] << @game.to_s
    @history[:round] << @round.to_s
  end

  def show_after_game_display
    display_game_winner
    update_game_count
    show_display
  end

  def update_game_count
    winner = human.score == MAX_SCORE ? human : computer
    winner.score.game += 1
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      prompt 'Sorry, must be y or n.'
    end
    answer == 'y'
  end

  def play_round
    update_round
    human.choose
    computer.choose
    update_history
    update_game_round
    update_score
    show_display
  end

  public

  def play
    display_welcome_message
    loop do
      play_round until [human.score, computer.score].include? MAX_SCORE
      show_after_game_display
      break unless play_again?
      next_game
      clear_screen
    end
    display_goodbye_message
  end
end

RPSGame.new.play
