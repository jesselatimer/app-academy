class Keypad
  attr_accessor :code_length, :mode_keys, :key_presses, :code_bank


  def initialize(code_length, mode_keys)
    @code_length = code_length
    @mode_keys = mode_keys
    @key_history = []
    @code_bank = Set.new
    @key_presses = 0
  end

  def press(key)
    @key_history << key
    @key_presses += 1
    if @key_history.length > @code_length
      if mode_keys.include?(key)
        @code_bank << @key_history[-(@code_length + 1)..-2]
      end
    end
  end

  def all_codes_entered?
    @code_bank.size == 10 ** code_length
  end

  def print_codes
    @code_bank.each do |code|
      p code
    end
    puts "Combo count: #{@code_bank.size}"
  end

end
