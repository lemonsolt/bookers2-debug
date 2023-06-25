class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render "/searches/search_result"
    else
      @books = Book.looks(params[:search], params[:word])
      render "/searches/search_result"
    end
  end

end
