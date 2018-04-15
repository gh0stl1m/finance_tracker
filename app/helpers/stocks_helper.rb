module StocksHelper
  def searchStock(tickerSimbol)
    # Get stock from api
    begin
      stockFound = StockQuote::Stock.quote(tickerSimbol)
      stockObj = {
        :name => stockFound.company_name,
        :ticker => stockFound.symbol,
        :last_price => stockFound.latest_price
      }
    rescue Exception => e
      puts "ERROR READING THE STOCK: #{e}"
      return nil
    end
  end

  def readByTicker(tickerSymbol)
    stock = Stock.find_by_ticker(tickerSymbol)
    puts "STOCK FOUND: #{stock}"
  end
end