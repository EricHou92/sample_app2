class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
     @comment_params = params.require(:comment).permit(:rating, :content, :thing_id)
    @comment_params.store(:user_id, session[:current_user_id]) # 当前用户ID
    @comment = Comment.new(@comment_params)
    if @comment.save
      redirect_to thing_path(Thing.find(@comment.thing_id)) # 重定向至待售物品详细信息页面
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.destroy
      redirect_to commented_path(User.find(@comment.user_id)) # 重定向至评论过商品列表页面
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:rating, :content, :user_id, :thing_id)
    end
end
