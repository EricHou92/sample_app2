class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :published, :collected, :commented]
  before_action :logged_in_user , only: [:edit , :update]
  before_action :correct_user ,      only: [:edit, :update]
  before_action :admin_user,        only:  :destory

  # GET /users
  # GET /users.json
  def index
    @users= User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
 def edit
   @user =  User.find(params[:id])
 end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)  #不是最终的实现方式
    if @user.save
      log_in @user
      flash[:success] = "欢迎来到果壳大二手！"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def  update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "资料已更新"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destory
    User.find(params[:id]).destory
    falsh[:success] = "用户已删除"
    redirect_to users_url
  end

  def published
    @things = Thing.where(:user_id => @user.id, :erasure => false) # 查找当前用户发布且未关闭交易的商品
  end

  def collected
    @collects = @user.collects
  end
  
  def commented
    @comments = @user.comments
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name , :mail , :password , :password_confirmation, :telephone)
    end

    #事前过滤器

    #确保用户已登陆
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请登陆."
        redirect_to login_url
      end
    end

    #确保是正确用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
  
    #确保是管理员
    def admin_user
      redirect_to(root_url)  unless current_user.admin?
    end
end
