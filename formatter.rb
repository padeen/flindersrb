module Formatter
  def stripQuotes(word)
    word.gsub(/"/, '')
  end

  def formatPrice(price)
    # remove point for thousands notation
    priceFormatted1 = price.gsub(/\./, '')
    # change to standard dot notation for decimals
    priceFormatted2 = priceFormatted1.gsub(/,/, '.')
  end
end
