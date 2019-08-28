class PlayersController < ApplicationController

  before_action :set_player, only: [:show, :update, :destroy]

  def index
    @players = Player.all
  end

  def show
  end

  def create
    @player = Player.new()
    @player.user = current_user
    Character::VALID_NAMES.
    # TODO: ASSIGN GAME
    # TODO: REDIRECT TO

  end

  def update
    # TODO: RE-ASSIGN PLAYER IS_ALIVE ATTRIBUTE ONLY
    # TODO: REDIRECT TO
  end

  def destroy
    @player.destroy
    # TODO: REDIRECT TO
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

end
