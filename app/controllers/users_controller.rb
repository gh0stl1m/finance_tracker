class UsersController < ApplicationController
  def selfPortfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end
end