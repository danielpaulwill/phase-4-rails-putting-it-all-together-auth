class RecipesController < ApplicationController

  def index
    user = User.find_by(id: session[:user_id])
    if user
      recipes = Recipe.all
      render json: recipes, include: :user, status: :created
    else
      user = User.first
      render json: { errors: user.errors.full_messages }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(id: session[:user_id])
    if user
      # puts recipe_params
      new_recipe = Recipe.new(user_id: user.id, title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete])
      if new_recipe.valid?
        new_recipe.save()
        render json: new_recipe, include: :user, status: :created
      else
        render json: { errors: new_recipe.errors.full_messages }, status: :unprocessable_entity
      end
    else
      user = User.first
      render json: { errors: user.errors.full_messages }, status: :unauthorized
    end
  end


  private

  def recipe_params
    params.permit(:user_id, :title, :instructions, :minutes_to_complete)
  end

end
