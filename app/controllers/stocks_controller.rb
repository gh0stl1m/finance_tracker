class StocksController < ApplicationController
  include StocksHelper
  # Method to find stocks
  def search
    if params[:stock].blank?
      flash.now[:danger] = "You have entered an empty string"
    else
      stockSearch = searchStock(params[:stock])
      if stockSearch
        puts "STOCK FOUND: #{stockSearch}"
        @stock = Stock.new(name: stockSearch[:name], ticker: stockSearch[:ticker], last_price: stockSearch[:last_price])
      else
        flash.now[:danger] = "You have entereded an incorrect symbol"
      end
    end
    render :partial => 'users/result'
  end

  # Method to create an user stock
  def create
    if current_user.canAddNewStock?(params[:user_stock])
      stock = readByTicker(params[:user_stock])
      if stock.blank?
        # Create new stock
        stockToCreate = searchStock(params[:user_stock])
        stock = Stock.new(name: stockToCreate[:name], ticker: stockToCreate[:ticker], last_price: stockToCreate[:last_price])
        stock.save
      end
      # Create user stock
      @user_stock = UserStock.create(user: current_user, stock: stock)
      flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to my portfolio"
    else
      flash[:danger] = "The user can not add this stock"
    end
    redirect_to users_self_portfolio_path
  end

  def remove
    stock = Stock.find(params[:format])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:notice] = "Stock was successfully removed from your portfolio"

    redirect_to users_self_portfolio_path
  end
end