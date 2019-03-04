class BooksController < ApplicationController

before_action :authenticate_user!

	def new
		@book=Book.new
	end

	def create
		@book=Book.new(book_params)
		@book.user_id= current_user.id
		if @book.save
		redirect_to books_path, notice:"私も#{@book.title}って本この夏読んでみます。"
	    else
	    @books =Book.all
		@user =current_user
	    render :index
	    end
	end

	def index
		# @books =Book.all.page(params[:page])
		@user =current_user
	    @book =Book.new
        @search = Book.page(params[:page]).ransack(params[:q])
        #ransackはdefaultでbook.allをひろってくるから、book.allはなくても大丈夫。
        #pageはransackよりも先に持ってくる！pageの方がモデルからひろってくるから、拾える範囲が広い？的な
        #controllerを書く順番を変えるだけで結構変わったりするから色々試すべし！
    	@books = @search.result
    end

	def show
		@book =Book.find(params[:id])
		@user =@book.user
	    @booker =Book.new
	end

	def destroy
		@book =Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def edit
	    @book = Book.find(params[:id])
    end

    def update
  	    @book =Book.find(params[:id])
  	    if @book.update(book_params)
		redirect_to book_path(@book.id), notice:"#{@book.title}編集完了！！"
	    else
	    @book = Book.find(params[:id])
	    render :edit
	    end
    end


private
    def book_params
    	params.require(:book).permit(:title,:body,:category)
    end

end
