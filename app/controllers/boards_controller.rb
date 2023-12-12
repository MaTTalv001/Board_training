class BoardsController < ApplicationController
  def new
    @board = Board.new
  end
  
  def index
    @boards = Board.all.order(created_at: :desc)
    @board = Board.new 
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to boards_path, success: I18n.t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now['danger'] = I18n.t('defaults.message.not_created', item: Board.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

   def destroy
    @board.destroy!
    redirect_to boards_path, status: :see_other, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
