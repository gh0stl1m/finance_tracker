class Stock < ApplicationRecord
  validates :name, presence: true
  validates :ticker, presence: true
  validates :last_price, presence: true
  # Associations
  has_many :user_stocks
  has_many :users, through: :user_stocks

  # Static methods for model
  def self.find_by_ticker(tickerSymbol)
    where(ticker: tickerSymbol).first
  end
end 