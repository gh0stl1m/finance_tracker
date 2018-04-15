class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Associations
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Static methods
  def isStockAlreadyAdded?(tickerSymbol)
    stock = Stock.find_by_ticker(tickerSymbol)
    return false unless stock
    # Validate if the user has stock
    isStockUser = UserStock.where(stock_id: stock.id, user_id: self.id).exists?
  end

  def underStockLimit?
    (user_stocks.count < 10)
  end

  def canAddNewStock?(tickerSymbol)
    !isStockAlreadyAdded?(tickerSymbol) && underStockLimit?
  end
end
