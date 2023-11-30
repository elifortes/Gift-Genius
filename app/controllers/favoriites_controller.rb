class FavoritesController < ApplicationController
  def new
    @occasion = Occasion.find(params[:occasion_id])
    @profile = @occasion.profile
  end

  def update
    raise
    @occasion = Occasion.find(params[:occasion_id])
    @favorite = Favorite.new
    @favorite.occasion = @occasion
    @favorite.user = current_user
    @favorite.save!
  end
end
