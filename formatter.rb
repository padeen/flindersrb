module Formatter
    
    def stripQuotes(word)
        word.gsub(/"/, "")
    end

    def formatPrice(price)
        priceFormatted1 = price.gsub(/\./, "")
        priceFormatted2 = priceFormatted1.gsub(/,/, ".")
    end
end