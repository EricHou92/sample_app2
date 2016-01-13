class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy, :refresh, :delete]
  include SessionsHelper

  # GET /things
  # GET /things.json
  def index
    @things = Thing.all
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @user = User.find(@thing.user_id) # 查找当前商品的卖家

    @comments = @thing.comments # 查找当前商品有关的评论

    @comment = Comment.new # 新建评论
  end

  # GET /things/new
  def new
    @thing = Thing.new
  end

  # GET /things/1/edit
  def edit
  end

  # POST /things
  # POST /things.json
  def create
    @thing_params = params.require(:thing).permit(:title, :depreciation_rate, :price, :style, :description, :picture)
    @thing_params.store(:user_id, current_user.id) # 当前用户ID
    @thing_params.store(:commission, false) # 默认为未申请代售
    @thing_params.store(:delivery, false) # 默认为未交付平台
    @thing_params.store(:erasure, false) # 默认为未达成交易
    @thing_params.store(:administrator_id, nil) # 默认没有管理员确认商品已交付
    @thing = Thing.new(@thing_params)
    if @thing.save
      redirect_to thing_path(@thing) # 重定向到新发布商品页面
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    @thing_params = params.require(:thing).permit(:commission)
    if @thing.update(@thing_params)
      redirect_to published_path(User.find(@thing.user_id)) # 重定向至已发布商品列表页面
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def refresh
    @thing_params = params.require(:thing).permit(:delivery)
    @thing_params.store(:administrator_id, current_user.id)
    if @thing.update(@thing_params)
      redirect_to audit_path # 重定向至审核页面
    else
      redirect_to root_path
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @collects = @thing.collects # 删除所有对该商品的关注
    @collects.each do |collect|
      collect.destroy
    end
    @comments = @thing.comments # 删除所有对该商品的评论
    @comments.each do |comment|
      comment.destroy
    end

    if @thing.update_attribute(:erasure, true) # 软删除，erasure位置1
      redirect_to published_path(User.find(@thing.user_id)) # 重定向至已发布商品列表页面
    else
      redirect_to root_path
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def delete
     @collects = @thing.collects # 删除所有对该商品的关注
    @collects.each do |collect|
      collect.destroy
    end
    @comments = @thing.comments # 删除所有对该商品的评论
    @comments.each do |comment|
      comment.destroy
    end

    if  @thing.update_attribute(:erasure, true) # 软删除，erasure位置1
      redirect_to audit_path # 重定向至审核页面
    else
      redirect_to root_path
    end
  end
  
  #GET /audit
  def audit
    if !current_user.admin?
      redirect_to root_path
    end
    @things = Thing.where(:commission => true, :erasure => false) # 查找已经申请代售但是尚未关闭交易的商品
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:title, :depreciation_rate, :price, :style, :description, :picture, :commission, :delivery, :erasure)
    end
end
