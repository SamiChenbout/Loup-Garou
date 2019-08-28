class PlayersController < ApplicationController
  # before_action :set_player, only: [:show, :update, :destroy]

  # def index
  #   @players = Player.all
  # end

  # def show
  # end

  # def create
  #   @player = Player.new
  #   @player.user = current_user
  #   Character::VALID_NAMES
    # TODO: ASSIGN GAME
    # TODO: REDIRECT TO
  # end

  # def update
    # TODO: RE-ASSIGN PLAYER IS_ALIVE ATTRIBUTE ONLY
    # TODO: REDIRECT TO
  # end

  # def destroy
  #   @player.destroy
    # TODO: REDIRECT TO
  # end

  def find_game
    @characters = Character.all
    if Game.where(step: "waiting") != []
      @game = Game.where(step: "waiting").first
      roles = @game.characters
      @characters -= roles
      @player = Player.new(user: current_user, game: @game, character: @characters.sample)
    else
      @game = Game.new
      @player = Player.new(user: current_user, game: @game, character: @characters.sample)
    end
    @game.save
    @player.save
    if @game.players.count > 5
      @game.update(step: "starting")
    end

    redirect_to game_path(@game)
  end

  private

  # def set_player
  #   @player = Player.find(params[:id])
  # end
end
