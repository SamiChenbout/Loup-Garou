class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @win = []
    all_char_win = []
    all_char_lose = []
    @lose = []
    @user.games.each do |game|
      player = Player.find_by(game: game, user: @user)
      if player.points != nil && player.points > 0
        @win << game
        all_char_win << player.character
      else
        @lose << game
        all_char_lose << player.character
      end
    end
    count_win = {}
    count_lose = {}
    all_char_win.each do |winner|
      if count_win.key?(winner.name)
        count_win[winner.name] += 1
      else
        count_win[winner.name] = 1
      end
    end
    all_char_lose.each do |looser|
      if count_lose.key?(looser.name)
        count_lose[looser.name] += 1
      else
        count_lose[looser.name] = 1
      end
    end
    @winner = Character.find_by(name: count_win.sort_by { |_key, value| value }.last)
    @looser = Character.find_by(name: count_lose.sort_by { |_key, value| value }.last)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :photo, :description)
  end
end
