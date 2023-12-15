class BoardsController < ApplicationController
  def new
    @board = Board.new
  end
  
  def index
    # current_date = Date.today
    # formatted_date = current_date.strftime('%m月%d日')
    # begin
      # @chatgpt = ChatgptService.call("簡単に挨拶してください。その際、#{formatted_date}が誕生日の有名人を簡単に紹介してください。")
    # rescue Net::ReadTimeout
      # @chatgpt = "ようこそ！今日は#{formatted_date}です。"
    # end
    @boards = Board.all.order(created_at: :desc)
    @board = Board.new 
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)
    if params[:board][:western_mode] == '1'
      begin
        @board.body = ChatgptService.call("次の入力文を関西弁にしてください 入力文：#{@board.body}")
      rescue Net::ReadTimeout
      end
    end
    if @board.save
      redirect_to boards_path, success: I18n.t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now['danger'] = I18n.t('defaults.message.not_created', item: Board.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

   def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    redirect_to boards_path, status: :see_other, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
