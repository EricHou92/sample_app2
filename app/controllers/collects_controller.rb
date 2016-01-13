class CollectsController < ApplicationController
  before_action :set_collect, only: [:show, :edit, :update, :destroy]

  # GET /collects
  # GET /collects.json
  def index
    @collects = Collect.all
  end

  # GET /collects/1
  # GET /collects/1.json
  def show
  end

  # GET /collects/new
  def new
    @collect = Collect.new
  end

  # GET /collects/1/edit
  def edit
  end

  # POST /collects
  # POST /collects.json
  def create
    @collect_params = params.require(:collect).permit(:thing_id)
    @collect_params.store(:user_id, session[:current_user_id]) # 当前用户ID
    @collect = Collect.new(@collect_params)
    if Collect.exists?(:user_id => @collect.user_id, :thing_id => @collect.thing_id) # 当前用户已经关注了该商品
      redirect_to collected_path(User.find(@collect.user_id))
    else
      if @collect.save
        redirect_to collected_path(User.find(@collect.user_id)) # 重定向至关注商品列表页面
      else
        redirect_to root_path
      end
    end
  end

  # PATCH/PUT /collects/1
  # PATCH/PUT /collects/1.json
  def update
    respond_to do |format|
      if @collect.update(collect_params)
        format.html { redirect_to @collect, notice: 'Collect was successfully updated.' }
        format.json { render :show, status: :ok, location: @collect }
      else
        format.html { render :edit }
        format.json { render json: @collect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collects/1
  # DELETE /collects/1.json
  def destroy
    if @collect.destroy
      redirect_to collected_path(User.find(@collect.user_id)) # 重定向至关注商品列表页面
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collect
      @collect = Collect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collect_params
      params.require(:collect).permit(:user_id, :thing_id)
    end
end
