require 'json'
load 'formatter.rb'
include Formatter

def calculateTotal(price, amount)
  (price * amount).round(2)
end

File.open('sales.csv') do |sales_csv|
  sales = {
    'tableNames' => [],
    'cohorts' => {}
  }
  sales_csv.each_line do |sale|
    saleClean = stripQuotes(sale)
    saleRow = saleClean.split(';')
    # [0] = cohort
    # [1] = price each
    # [2] = amount
    # [3] = date

    # create first array with table names if sales is empty
    if !sales['tableNames'][0]
      sales['tableNames'].push(saleRow[0])
      sales['tableNames'].push(saleRow[1])
      sales['tableNames'].push(saleRow[2])
      sales['tableNames'].push(saleRow[3])
    elsif !sales['cohorts'].key?(saleRow[0])
    # if cohort does not yet exist create it
      sales['cohorts'][saleRow[0]] = [[], []]
      formattedPrice = formatPrice(saleRow[1])
      totalPrice = calculateTotal(formattedPrice.to_f, saleRow[2].to_f)
      sales['cohorts'][saleRow[0]][0].push(saleRow[3])
      sales['cohorts'][saleRow[0]][1].push(totalPrice)
    # add total price and date to existing cohort
    else
      formattedPrice = formatPrice(saleRow[1])
      totalPrice = calculateTotal(formattedPrice.to_f, saleRow[2].to_f)
      sales['cohorts'][saleRow[0]][0].push(saleRow[3])
      sales['cohorts'][saleRow[0]][1].push(totalPrice)
    end
  end

  puts sales
  puts sales.to_json
end
