class SearchesController < ApplicationController
  def index
    @posts = Post.search(params[:keyword])
    @members = Member.search(params[:keyword])
    @trainers = Trainer.search(params[:keyword])
  end
end
