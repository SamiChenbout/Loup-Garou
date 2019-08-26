class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(characters_params)
  end

  def characters_params
    params.require(:character).permit(:picture, :description, :name)
  end
end
