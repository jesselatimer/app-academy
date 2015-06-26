# def make_change(change, coin_types = [25, 10, 5, 1])
#   return [] if change < 1
#
#   coin_type = coin_types.find { |coin| coin <= change }
#
#   coins = make_change(change - coin_type)
#   coins.unshift(coin_type)
# end

def make_change(change, coin_types = [25, 10, 5, 1])
  return [] if change < 1

  best ||= []
  coin_types.each do |coin|
    next if change < coin
    current = [coin] + make_change(change - coin, coin_types)
    best = current if current.length < best.length || best.empty?
  end

  best
end

p make_change(123)
