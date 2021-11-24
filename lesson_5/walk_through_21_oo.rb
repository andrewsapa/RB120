#### OO 21 ####

require 'pry'

class Participant
  attr_reader :name
  attr_accessor :points
  
  def initialize
    @name = name
    @points = 0
  end
  
  def hit
    deal_card
  end

  def stay
  end
  
  def busted?
    total > 21
  end
  
  def total
    
  end
end

class Dealer < Participant
  HOLD = 17
  
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
  def initializes
    @name = set_name
    @points = 0
  end
  
  def valid_input(input)
    !input.empty?
  end
  
  def set_name
    loop do 
      puts "What's your name?"
      input = gets.chomp
      break if valid_input(input)
      puts "Sorry! You must type a name."
    end
  end
end

class Deck
  attr_accessor :cards
  
  def initialize
    @cards = []
  end

  def deal
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << [value, suit]
      end
    end
    shuffler!
  end
  
  def shuffller!
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end

class Card
  attr_reader :suit, :face
  
  SUITS = ['C', 'H', 'S', 'D']
  
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', 'J',
          'Q', 'K', 'A']
          
  def initialize(suit, face)
    @suit = suit
    @face = face
  end
  
  def suits_transformation
    case @suit
    when 'C' then 'Clubs'
    when 'H' then 'Hearts'
    when 'S' then 'Spades'
    when 'D' then 'Diamonds'
    else
      @suit
    end
  end
  
  def face_transformation
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end
  
  def points_transformation
    case VALUES
    when '2' then 2
    when '3' then 3
    when '4' then 4
    when '5' then 5
    when '6' then 6
    when '7' then 7
    when '8' then 8
    when '9' then 9
    when 'J' then 10
    when 'Q' then 10
    when 'K' then 10
    when 'A' then [1, 11]
    else
      VALUES
    end
  end
end

class Game
  attr_reader :deck, :dealer, :human

  WIN = 21

  MATCH_WIN = 5
  
  @@player_hand = []
  @@dealer_hand = []

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def prompt(msg)
    puts "=>#{msg}"
  end

  def clear_screen
    system 'clear'
  end

  def welcome
    loop do 
      prompt "Welcome to #{WIN}!"
      prompt "First to #{MATCH_WIN} games wins the match."
      prompt "press 'enter to continue"

      input = gets.chomp
      break if input
    end
    clear_screen
  end

  def deal_cards
    2.times do 
      binding.pry
      @@player_hand << deck.deal_card
      @@dealer_hand << deck.deal_card
    end
  end
  
  def show_player_cards
    @@player_hand.each do |card|
      return "Your hand: #{card.suits_transformation} #{card.face_transformation}"
    end
  end
  
  def show_dealer_chards
    @@dealer_hand.each do |card|
      return "Your hand: #{card.suits_transformation} #{card.face_transformation}"
    end
  end
  
  def show_initial_cards
    puts show_player_cards
    puts show_dealer_chards
  end
  
  def detect_result
    if player.points > WIN
      'player_busted'
    elsif dealer.points > WIN
      'dealer_busted'
    elsif dealer.points < player.points
      'player'
    elsif dealer.points > player.points
      'dealer'
    else
      'tie'
    end
  end

  def display_result
    case detect_result
    when 'player_busted'
      prompt 'You busted! Dealer wins!'
    when 'dealer_busted'
      prompt 'Dealer busted! You win!'
    when 'player'
      prompt 'You win!'
    when 'dealer'
      prompt 'Dealer wins!'
    when 'tie'
      prompt "It's a tie!"
    end
  end
  
  def play_again?
    valid_responses = ['y', 'yes', 'n', 'no']
    input = ""
    loop do 
      puts "Would you like to play again? (y/n)"
      input = gets.chomp.downcase
      break if valid_responses.include?(input)
      puts "Sorry! That's an invalid response."
    end
    valid_responses[0..1].include?(input)
  end

  def start
    welcome
    loop do 
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn
      display_result
      break unless play_again?
    end
  end
end

Game.new.start
