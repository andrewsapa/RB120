#### OO TTT Bonus Features ####

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def marked_keys
    @squares.keys.select { |key| @squares[key].marked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def computer_offense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares) && computer_markers?(squares)
        return find_best_square(squares)
      end
    end
    nil
  end

  def computer_defense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares) && player_markers?(squares)
        return find_best_square(squares)
      end
    end
    nil
  end

  def find_best_square(squares)
    hsh = {}
    squares.each do |square|
      @squares.each do |k, v|
        if square.marker == " " && square == v
          hsh[k] = square
        end
      end
    end
    hsh.keys[0]
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def player_markers?(squares)
    squares.any? { |square| square.marker == TTTGame.human_marker }
  end

  def computer_markers?(squares)
    squares.any? { |square| square.marker == TTTGame.computer_marker }
  end

  def two_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :name
end

class Human < Player
  def initialize
    set_human_name
    @marker = set_marker
  end

  def valid_name?(n)
    n.empty? || n == " "
  end

  def set_human_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless valid_name?(n)
      puts "Sorry, must enter a value."
    end
    self.name = n
    system('clear')
  end

  def valid_marker?(input)
    input.size == 1 && input != 'O' && input != " "
  end

  def set_marker
    input = ""
    loop do
      puts "Please pick a game marker."
      puts "You can pick any game marker (NOT 'O') up to one character length."
      input = gets.chomp.to_s.upcase
      break if valid_marker?(input)
      puts "Sorry, invalid game marker."
    end
    input
  end
end

class Computer < Player
  def initialize
    @marker = set_marker
    set_computer_name
  end

  def set_computer_name
    @name = ['R2D2', 'Hal', 'Chappie', 'Sonnie', 'Number5'].sample
  end

  def set_marker
    "O"
  end
end

class TTTGame
  MATCH_WINS = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = nil
    @computer_wins = 0
    @human_wins = 0
    @options = ['p', 'player', 'c', 'computer', 'x']
    @@human_marker = human.marker
    @@computer_marker = computer.marker
  end

  def self.human_marker
    @@human_marker
  end

  def self.computer_marker
    @@computer_marker
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  # rubocop:disable Metrics/MethodLength
  def main_game
    loop do
      display_board
      select_who_goes_first_message
      display_who_goes_first_message
      player_move
      display_result
      display_match_winner
      break unless play_again?
      reset
      display_play_again_message
      clear_match_wins
    end
  end
  # rubocop:enable Metrics/MethodLength

  def player_move
    loop do
      current_player_moves
      wins_tracker
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = @@computer_marker
    else
      computer_moves
      @current_marker = @@human_marker
    end
  end

  def human_turn?
    @current_marker == @@human_marker
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
    puts ""
    puts "The first to win #{MATCH_WINS} games, wins the match."
    puts ""
  end

  def select_who_goes_first_message
    puts "Who would you like to go first? (p/player for c/computer)"
    puts "Or you can let computer decide. (type 'x')"
    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if @options.include?(choice)
      puts "Sorry, that's an incorrect response!"
    end
    decide_who_goes_first(choice)
  end

  def decide_who_goes_first(choice)
    if @options[0..1].include?(choice)
      @current_marker = human.marker
    elsif @options[2..3].include?(choice)
      @current_marker = computer.marker
    elsif @options[-1].include?(choice)
      @current_marker = [human.marker, computer.marker].sample
    end
  end

  def display_who_goes_first_message
    case @current_marker
    when @@computer_marker
      puts "Computer goes first."
      sleep(0.75)
    when @@human_marker
      puts "You get to go first!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    display_names_and_markers
    puts ""
    board.draw
    puts ""
    display_names_and_wins
    puts ""
  end

  def display_names_and_markers
    puts "#{human.name} is #{human.marker}. #{computer.name} is " \
    "#{computer.marker}."
  end

  def display_names_and_wins
    puts "#{human.name} wins: #{@human_wins}. #{computer.name} wins: " \
    "#{@computer_wins}."
  end

  def joinor(array)
    if array.size == 2
      array.join(' ').insert(-2, "or ")
    elsif array.size == 1
      array.join
    else
      array.join(', ').insert(-2, "or ")
    end
  end

  def integer?(square)
    square.to_i.to_s == square
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp
      break if board.unmarked_keys.include?(square.to_i) && integer?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square.to_i] = human.marker
  end

  # rubocop:disable Metrics/AbcSize
  def computer_moves
    if !board.computer_offense.nil?
      board[board.computer_offense] = computer.marker
    elsif !board.computer_defense.nil?
      board[board.computer_defense] = computer.marker
    elsif board.squares[5].marker == " "
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end
  # rubocop:enable Metrics/AbcSize

  def wins_tracker
    case board.winning_marker
    when human.marker
      @human_wins += 1
    when computer.marker
      @computer_wins += 1
    end
  end

  def match_winner?
    @human_wins == MATCH_WINS || @computer_wins == MATCH_WINS
  end

  def display_match_winner
    if @human_wins == MATCH_WINS
      puts ""
      puts "***Congratulations! #{human.name} won the match!***"
      puts ""
    elsif @computer_wins == MATCH_WINS
      puts ""
      puts "***Sorry! #{computer.name} won the match!***"
      puts ""
    end
  end

  def clear_match_wins
    return unless match_winner?
    @human_wins = 0 && @computer_wins = 0
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
