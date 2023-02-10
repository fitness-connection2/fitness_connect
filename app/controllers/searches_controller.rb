class SearchesController < ApplicationController

  def index
    @posts = Post.search(params[:keyword])
    @members = Member.search(params[:keyword])
    @trainers = Trainer.search(params[:keyword])
  end

  private

  # def authenticated_any
  #   unless member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  #     flash[:notice] = "ログインが必要です。"
  #     redirect_to posts_path
  #   end
  # end
end
