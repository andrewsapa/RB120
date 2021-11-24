#### OO 21 ####

require 'pry'

class Participant
  attr_accessor :points, :name

  def initialize
    @name = name
    @points = 0
  end

  def hit
    deal_card
  end
end

class Dealer < Participant
  DEALERS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def initialize
    @name = set_name
    @points = 0
  end

  def set_name
    DEALERS.sample
  end
end

class Player < Participant
  def initialize
    @name = name
    @points = 0
  end

  def valid_input(input)
    !input.empty?
  end

  def set_name
    loop do
      puts "What's your name?"
      @name = gets.chomp
      break if valid_input(name)
      puts "Sorry! You must type a name."
    end
    @name
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    deal
  end

  def deal
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_card
    cards.pop
  end
end

class Card
  SUITS = ['C', 'H', 'S', 'D']

  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', 'J',
           'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def suit
    case @suit
    when 'C' then 'Clubs'
    when 'H' then 'Hearts'
    when 'S' then 'Spades'
    when 'D' then 'Diamonds'
    else
      @suit
    end
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end
end

class Game
  attr_reader :deck, :dealer, :player

  WIN = 21

  MATCH_WIN = 5

  BUSTED = 22

  HOLD = 17

  VALID_RESPONSES = ['h', 'hit', 's', 'stay', 'y', 'yes', 'n', 'no']

  @@player_hand = []
  @@dealer_hand = []

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @@player_wins = 0
    @@dealer_wins = 0
  end

  def welcome
    loop do
      puts "Welcome to #{WIN}!"
      puts "First to #{MATCH_WIN} games wins the match."
      puts "press 'enter to continue"

      input = gets.chomp
      break if input
    end
    player.set_name
    clear_screen
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def player_turn
    prompt "It's #{player.name}'s turn..."

    loop do
      prompt "Would you like to hit or stay? (h/s)"
      input = nil

      loop do
        input = gets.chomp.downcase
        break if VALID_RESPONSES[0..3].include?(input)
        prompt "Sorry! Invalid input."
      end

      if VALID_RESPONSES[2..3].include?(input)
        prompt "#{player.name} stays!"
        break
      elsif player_total_points >= BUSTED
        break
      else
        @@player_hand << deck.deal_card
        prompt "#{player.name} hits!"
        show_player_cards
        break if player_total_points > WIN
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    loop do
      if dealer_total_points >= HOLD && dealer_total_points <= WIN
        prompt "#{dealer.name} stays!"
        break
      elsif dealer_total_points >= BUSTED
        break
      elsif player_total_points >= BUSTED
        break
      else
        puts ""
        puts "#{dealer.name} hits!"
        @@dealer_hand << deck.deal_card
        prompt "#{dealer.name} draws:"
        puts "#{@@dealer_hand[-1].face} of #{@@dealer_hand[-1].suit}"
      end
    end
    continue
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def continue
    input = ''
    user_input = []
    loop do
      prompt "Type any button to continue: "
      input = gets.chomp
      user_input.push(input)
      break if !user_input.empty?
    end
  end

  def deal_initial_cards
    2.times do
      @@player_hand << deck.deal_card
      @@dealer_hand << deck.deal_card
    end
  end

  def show_player_cards
    prompt "#{player.name}'s' hand:"
    @@player_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
    puts
  end

  def show_dealer_cards
    first_card = @@dealer_hand.first
    prompt "#{dealer.name}'s hand:"
    puts "#{first_card.face} of #{first_card.suit} and ??"
    puts
  end

  def show_hand(cards, name, total)
    prompt "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
    prompt "Total: #{total}"
    puts ""
  end

  def display_flop
    clear_screen
    display_game_wins
    show_hand(@@player_hand, player.name, player_total_points)
    show_hand(@@dealer_hand, dealer.name, dealer_total_points)
  end

  def ace_checker(cards, participant_points)
    if cards.any? { |card| card.face == "Ace" } && participant_points > WIN
      participant_points -= 10
    end
    participant_points
  end

  def points_tracker(cards, participant_points)
    cards.each do |card|
      if card.face == 'Ace'
        participant_points += 11
      elsif card.face == 'Jack' || card.face == 'Queen' || card.face == 'King'
        participant_points += 10
      else
        participant_points += card.face.to_i
      end
    end
    ace_checker(cards, participant_points)
  end

  def player_total_points
    points_tracker(@@player_hand, player.points)
  end

  def dealer_total_points
    points_tracker(@@dealer_hand, dealer.points)
  end

  # rubocop:disable Metrics/MethodLength
  def detect_result
    if player_total_points >= BUSTED
      'player_busted'
    elsif dealer_total_points >= BUSTED
      'dealer_busted'
    elsif dealer_total_points < player_total_points
      'player'
    elsif dealer_total_points > player_total_points
      'dealer'
    else
      'tie'
    end
  end
  # rubocop:enable Metrics/MethodLength

  def display_result
    case detect_result
    when 'everyone_busted' then prompt "Everyone busted! It's a tie!"
    when 'player_busted' then prompt 'You busted! Dealer wins!'
    when 'dealer_busted' then prompt 'Dealer busted! You win!'
    when 'player' then prompt 'You win!'
    when 'dealer' then prompt 'Dealer wins!'
    when 'tie' then prompt "It's a tie!"
    end
  end

  def win_tracker
    case detect_result
    when 'player_busted'
      @@dealer_wins += 1
    when 'dealer_busted'
      @@player_wins += 1
    when 'player'
      @@player_wins += 1
    when 'dealer'
      @@dealer_wins += 1
    end
  end

  def reset_wins
    return unless @@dealer_wins == MATCH_WIN || @@player_wins == MATCH_WIN
    @@dealer_wins = 0
    @@player_wins = 0
  end

  def display_match_winner
    if @@dealer_wins == MATCH_WIN
      prompt "--------Sorry! #{dealer.name} won the match.--------"
      puts ""
    elsif @@player_wins == MATCH_WIN
      prompt "--------Congratulations! You won the match!--------"
      puts ""
    end
  end

  def display_game_wins
    prompt "#{player.name}'s wins: #{@@player_wins}, " \
           "#{dealer.name}'s wins: #{@@dealer_wins}"
    puts ""
  end

  def play_again?
    input = ""
    loop do
      puts ""
      puts "Would you like to play again? (y/n)"
      input = gets.chomp.downcase
      break if VALID_RESPONSES[4..-1].include?(input)
      puts "Sorry! That's an invalid response."
    end
    display_game_wins
    VALID_RESPONSES[4..5].include?(input)
  end

  def reset
    @deck = Deck.new
    @@player_hand = []
    @@dealer_hand = []
    clear_screen
  end

  def prompt(msg)
    puts "=>#{msg}"
  end

  def clear_screen
    system 'clear'
  end

  def timer(time)
    sleep(time)
  end

  def display_goodbye
    prompt "Thank you for playing! Goodbye."
  end

  # rubocop:disable Metrics/MethodLength
  def start
    welcome
    display_game_wins
    loop do
      deal_initial_cards
      show_player_cards
      show_dealer_cards
      player_turn
      dealer_turn
      win_tracker
      display_flop
      display_result
      display_match_winner
      break unless play_again?
      reset_wins
      display_game_wins
      reset
    end
    display_goodbye
  end
  # rubocop:enable Metrics/MethodLength
end

Game.new.start
