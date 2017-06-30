class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership! , only: [:destroy]


  def create
      new_comment = Comment.new(content:params[:content],
                                post_id: params[:post_id],
                                user_id: current_user.id)
      new_comment.save
      redirect_to :back
  end
  def destroy
    comment= Comment.find(params[:id])
    comment.destroy
    redirect_to :back
  end

  private
    def check_ownership!
      comment= Comment.find(params[:id])
      redirect_to '/' if comment.user.id !=current_user.id
    end
end
