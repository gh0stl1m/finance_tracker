class UsersController < ApplicationController
  include UsersHelper
  def selfPortfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def readFriends
    @friendship = current_user.friends
    puts "USER FRIENDS: #{@friendship}"
  end
  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty string"
    else
      @users = searchUser(params[:search_param])
      @users = excludeFromSearch(@users, current_user)
      puts "USERS BLANK? #{@users.blank?}"
      flash[:danger] = "No users match with this search critera" if @users.blank?
    end
    render :partial => 'friends/result'
  end

  def addFriend
    @friend = User.find(params[:friend])
    puts "FRIEND FOUND: #{@friend.fullName}"
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:notice] = "Friend was successfully added"
    else
      flash[:danger] = "There was something wrong with the friend request"
    end  
    redirect_to users_friends_path
  end
  def removeFriend
    @friend = Friendship.where(user_id: current_user.id, friend_id: params[:format]).first
    @friend.destroy
    flash[:notice] = "Friend was successfully removed from your list"

    redirect_to users_friends_path
  end

  def readById
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end
end