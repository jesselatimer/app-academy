def make_change(change, coins = [25, 10, 5, 1]) # Defaults US coins.
  return [] if change < 1

  coins = coins.sort.reverse

  best ||= []
  coins.each_with_index do |coin, used_coins|
    next if change < coin
    current = [coin] + make_change(change - coin, coins.drop(used_coins))
    best = current if current.length < best.length || best.empty?
  end

  best
end
