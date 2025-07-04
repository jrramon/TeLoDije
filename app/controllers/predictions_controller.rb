class PredictionsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_prediction, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.ordered
    @predictions = Prediction.active.recent.includes(:user, :votes, :category)
    @predictions = @predictions.by_category(params[:category_id]) if params[:category_id].present?
  end

  def show
    @vote = @prediction.votes.find_by(user: current_user) if logged_in?
  end

  def new
    @prediction = current_user.predictions.build
    @categories = Category.ordered
  end

  def create
    @prediction = current_user.predictions.build(prediction_params)
    
    if @prediction.save
      current_user.update_stats
      redirect_to @prediction, notice: 'Predicción creada exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @prediction.update(prediction_params)
      redirect_to @prediction, notice: 'Predicción actualizada exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prediction.destroy
    redirect_to predictions_path, notice: 'Predicción eliminada'
  end

  private

  def set_prediction
    @prediction = Prediction.find(params[:id])
  end

  def prediction_params
    params.require(:prediction).permit(:title, :question, :resolution_date, :source, :hint, :category_id)
  end
end 