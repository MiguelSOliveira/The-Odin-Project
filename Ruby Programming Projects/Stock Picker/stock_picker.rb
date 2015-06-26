def stock_picker prices
  price, sell, buy = 0, 0, 0
  (0...prices.size).each do |i|
    (i+1...prices.size).each do |j|
      if (prices[j]-prices[i]) > price
        price = (prices[j]-prices[i])
        buy = i
        sell = j
      end
    end
  end
  puts "[#{buy}, #{sell}]"
end

stock_picker [17,3,6,9,15,8,6,1,10]
