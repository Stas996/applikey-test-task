class UsersController < ApplicationController
  before_action :logged_in?, except: [:show, :new, :create]
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
        
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Профиль успешно создан!'
    else
      render :new
    end
  end

  def update
    if @user.update(image: params[:image])
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Профиль успешно удален.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :birth_date, :email, :password, :password_confirmation)
    end
end
