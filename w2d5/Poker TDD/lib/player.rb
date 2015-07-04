require_relative 'hand'
require_relative 'deck'

class Player

  attr_reader :hand, :pot, :name

  def initialize(name = "defecto", pot = 500, deck)
    @name, @pot = name, pot
    new_round(deck)
  end

  def new_round(deck)
    @deck = deck
    @hand = Hand.new(deck.draw(5))
  end

  def discard_at(list_of_indexes)
    hand.discard_at(list_of_indexes)
    hand.receive_card(deck.draw(1)) until hand.count == 5
  end

  def get_bet
    puts "how much do you want to bet, bro?"
    puts "your pot is currently at #{pot}"
    begin
      input = 10 #gets.to_i
      raise "Not a valid bet." if input < 1 || input > pot
    rescue => e
      puts e.message
      retry
    end
    @pot -= input
    input
  end

  def get_user_input(current_bet)
    begin
      input = "f"
      case input
      when "f"
        fold
      when "s"
        if current_bet > pot
          puts "Not enough money."
          fold
        else
          see(current_bet)
        end
      when "r"
        if current_bet > pot
          puts "Not enough money."
          fold
        else
          raise_bet(current_bet)
        end
      end
    rescue
      puts "Not a valid entry."
      retry
    end
  end

  def fold
    [:fold, 0]
  end

  def see(bet)
    @pot -= bet
    [:see, bet]
  end

  def raise_bet(bet)
    @pot -= bet
    puts "How much to raise by?"
    begin
      raise_amount = 30 # gets.to_i
      raise "Not enough money." unless raise_amount < pot
      raise "Not a valid raise amount." if raise_amount < 1
    rescue => e
      print e.message
      retry
    end
    @pot -= raise_amount
    [:raise, bet + raise_amount]
  end


  private
  attr_writer :hand, :deck, :pot


end
