class SearchesController < ApplicationController
  def index
      @posts = Post.search(params[:keyword])
      @search_word = params[:keyword]
  end    
end
