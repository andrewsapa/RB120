#### RPS Bonus Features ####

class Move
  attr_accessor :winning_moves, :losing_moves, :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  ABBR = { 'r' => 'rock',
           'p' => 'paper',
           's' => 'scissors',
           'l' => 'lizard',
           'sp' => 'spock' }

  def self.create(choice)
    case choice
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end

  def initialize(value)
    @value = value
  end

  def >(other_move)
    winning_moves.include?(other_move)
  end

  def <(other_move)
    losing_moves.include?(other_move)
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @winning_moves = ['lizard', 'scissors']
    @losing_moves = ['spock', 'paper']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @winning_moves = ['spock', 'rock']
    @losing_moves = ['lizard', 'scissors']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @winning_moves = ['lizard', 'paper']
    @losing_moves = ['rock', 'spock']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @winning_moves = ['spock', 'paper']
    @losing_moves = ['scissors', 'rock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @winning_moves = ['scissors', 'rock']
    @losing_moves = ['paper', 'lizard']
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    set_name
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
    system('clear')
  end

  def choose(choice = nil)
    loop do
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock:"
      choice = gets.chomp.downcase
      Move::ABBR.keys.include?(choice) ?  choice = Move::ABBR[choice] : choice
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.create(choice).value
  end
end

class Computer < Player
end

class R2D2 < Computer
  def initialize
    @score = 0
    @name = "R2D2"
  end

  def choose
    @move = 'rock'
  end
end

class Hal < Computer
  def initialize
    @score = 0
    @name = "Hal"
  end

  def choose
    @move = ['scissors', 'scissors', 'scissors', 'rock'].sample
  end
end

class Chappie < Computer
  def initialize
    @score = 0
    @name = "Chappie"
  end

  def choose
    @move = ['scissors', 'paper', 'lizard', 'rock', 'spock'].sample
  end
end

class Sonnie < Computer
  def initialize
    @score = 0
    @name = "Chappie"
  end

  def choose
    @move = ['scissors', 'paper', 'lizard', 'rock', 'spock'].sample
  end
end

class Number5 < Computer
  def initialize
    @score = 0
    @name = "Number5"
  end

  def choose
    @move = ['spock', 'spock', 'lizard', 'rock', 'spock'].sample
  end
end

class RPSGame
  attr_accessor :human, :computer, :move_history, :rounds

  MATCH_WINS = 5

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Chappie.new, Sonnie.new, Number5.new].sample
    @ties = 0
    @move_history = {}
    @rounds = 0
  end

  def print_in_box(str)
    middle = "| #{str.center(str.length % 50)} |"
    line = "-" * (str.length)
    filler = " " * str.length
    puts "+-#{line}-+"
    puts "| #{filler} |"
    puts middle
    puts "| #{filler} |"
    puts "+-#{line}-+"
  end

  def display_welcome_message
    print_in_box("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
    print_in_box("First person to win 10 rounds wins the match.")
  end

  def display_goodbye_message
    print_in_box("Thanks for playing Rock, Paper, Scissors. Goody bye!")
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def score_tracker
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    else
      @ties += 1
    end
  end

  def display_match_winner
    if human.score == MATCH_WINS
      print_in_box("********Congratulations! You won the match!********")
    elsif computer.score == MATCH_WINS
      print_in_box("********Sorry! #{computer.name} won the match!********")
    end
  end

  def reset_scores
    return unless human.score == MATCH_WINS || computer.score == MATCH_WINS
    human.score = 0 && computer.score = 0 && @ties = 0
  end

  def display_score
    puts "#{human.name} wins: #{human.score}"
    puts "#{computer.name} wins: #{computer.score}"
    puts "Game ties: #{@ties}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def add_move_to_history
    @rounds += 1
    @move_history[human.name + " Round #{rounds}"] = human.move
    @move_history[computer.name + " Round #{rounds}"] = computer.move
  end

  def display_move_history
    move_history.each do |player, move|
      puts "#{player} moved: #{move}"
      puts "---------------------------"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer == 'y'
  end

  # rubocop:disable Metrics/MethodLength
  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      add_move_to_history
      score_tracker
      display_moves
      display_winner
      display_score
      display_match_winner
      reset_scores
      break unless play_again?
      system('clear')
    end
    display_goodbye_message
    display_move_history
  end
  # rubocop:enable Metrics/MethodLength
end

RPSGame.new.play
