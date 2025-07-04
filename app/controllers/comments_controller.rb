class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_prediction, only: [:create]
  before_action :set_comment, only: [:destroy]
  before_action :ensure_comment_owner, only: [:destroy]
  
  def create
    @comment = @prediction.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @prediction, notice: 'Comentario agregado exitosamente.'
    else
      redirect_to @prediction, alert: 'Error al agregar comentario.'
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to @comment.prediction, notice: 'Comentario eliminado exitosamente.'
  end
  
  private
  
  def set_prediction
    @prediction = Prediction.find(params[:prediction_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def ensure_comment_owner
    unless @comment.user == current_user
      redirect_to @comment.prediction, alert: 'No tienes permisos para eliminar este comentario.'
    end
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end 