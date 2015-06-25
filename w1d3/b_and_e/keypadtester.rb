# Jesse Latimer & Robin Wu

require_relative 'keypad'
require 'set'

class KeypadTester

  def initialize(code_length = 4, mode_keys = [1,2,3])
    @code_length = code_length
    @mode_keys = mode_keys
    @keypad = Keypad.new(@code_length, @mode_keys)
  end

  def run
    # Mostly brute force, but elimanets some key presses followed by our
    # first mode_key.
    i = 0
    until @keypad.all_codes_entered? do
      current_code = i.to_s.rjust(@code_length, "0").split("").map(&:to_i)
      if @keypad.code_bank.include?(current_code)
        i += 1
        next
      end
      current_code.each do |key|
        @keypad.press(key)
      end
      @keypad.press(@mode_keys[0])
      i += 1
    end
    @keypad.print_codes
    puts "Key presses: #{@keypad.key_presses}"
  end

end

puts "How many digits is your code?"
keypadtester = KeypadTester.new(gets.to_i)
start = Time.now
keypadtester.run
puts Time.now - start
