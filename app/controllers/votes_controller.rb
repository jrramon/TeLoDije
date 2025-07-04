class VotesController < ApplicationController
  before_action :require_login
  before_action :set_prediction

  def create
    @vote = @prediction.votes.build(vote_params)
    @vote.user = current_user
    
    if @vote.save
      redirect_to @prediction, notice: 'Voto registrado exitosamente'
    else
      redirect_to @prediction, alert: @vote.errors.full_messages.join(', ')
    end
  end

  def destroy
    @vote = @prediction.votes.find_by(user: current_user)
    
    if @vote&.destroy
      redirect_to @prediction, notice: 'Voto eliminado'
    else
      redirect_to @prediction, alert: 'No se pudo eliminar el voto'
    end
  end

  private

  def set_prediction
    @prediction = Prediction.find(params[:prediction_id])
  end

  def vote_params
    params.require(:vote).permit(:outcome, :points)
  end
end
