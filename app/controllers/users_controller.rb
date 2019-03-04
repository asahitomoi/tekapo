class UsersController < ApplicationController

before_action :authenticate_user!

  def show
  	user =current_user
	@user =User.find(params[:id])
	@books =@user.books
	@book =Book.new
  end

  def edit
	@user = User.find(params[:id])
  end

  def update
  	@user =User.find(params[:id])
  	if @user.update(user_params)
     redirect_to user_path(@user.id), notice: "#{@user.name}の編集完了!!"
    else
    @books =@user.books
	@book =Book.new
    render :show

    end
  end

  def index
  	@users =User.all
  	@user =current_user
	@book =Book.new

	@search = Book.search(params[:q])
    @books = @search.result(distinct: true)
  end

  def search
    @search = Book.search(search_params)
    @books = @search.result(distinct: true)
  end



private
  def search_params
    params.require(:q).permit!
  end


  def user_params
	params.require(:user).permit(:name,:image, :body)
  end

end
